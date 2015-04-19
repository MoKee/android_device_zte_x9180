/*
   Copyright (c) 2014, The Linux Foundation. All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <stdio.h>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mount.h>


#include "init_msm.h"

#define PERSISTENT_PROPERTY_DIR  "/data/property"

void init_msm_properties(unsigned long msm_id, unsigned long msm_ver, char *board_type)
{
    UNUSED(msm_id);
    UNUSED(msm_ver);
    UNUSED(board_type);
    
    char value[PROP_VALUE_MAX];
    int rc;
    
    DIR* dir = opendir(PERSISTENT_PROPERTY_DIR);
    int dir_fd;
    struct dirent*  entry;
    int fd, length;
    struct stat sb;

    if (dir) {
        dir_fd = dirfd(dir);
        while ((entry = readdir(dir)) != NULL) {
// we need to read this properties before load_persistent_properties()
            if (strncmp("persist.zram.planned_size", entry->d_name, strlen("persist.zram.planned_size")) &&
	      strncmp("persist.storages.planned_swap", entry->d_name, strlen("persist.storages.planned_swap")))
                continue;
#if HAVE_DIRENT_D_TYPE
            if (entry->d_type != DT_REG)
                continue;
#endif
            /* open the file and read the property value */
            fd = openat(dir_fd, entry->d_name, O_RDONLY | O_NOFOLLOW);
            if (fd < 0) {
                ERROR("Unable to open persistent property file \"%s\" errno: %d\n",
                      entry->d_name, errno);
                continue;
            }
            if (fstat(fd, &sb) < 0) {
                ERROR("fstat on property file \"%s\" failed errno: %d\n", entry->d_name, errno);
                close(fd);
                continue;
            }

            // File must not be accessible to others, be owned by root/root, and
            // not be a hard link to any other file.
            if (((sb.st_mode & (S_IRWXG | S_IRWXO)) != 0)
                    || (sb.st_uid != 0)
                    || (sb.st_gid != 0)
                    || (sb.st_nlink != 1)) {
                ERROR("skipping insecure property file %s (uid=%u gid=%u nlink=%d mode=%o)\n",
                      entry->d_name, (unsigned int)sb.st_uid, (unsigned int)sb.st_gid,
                      sb.st_nlink, sb.st_mode);
                close(fd);
                continue;
            }

            length = read(fd, value, sizeof(value) - 1);
            if (length >= 0) {
                value[length] = 0;
                property_set(entry->d_name, value);
            } else {
                ERROR("Unable to read persistent property file %s errno: %d\n",
                      entry->d_name, errno);
            }
            close(fd);
        }
        closedir(dir);
    } else {
        ERROR("Unable to open persistent property directory %s errno: %d\n", PERSISTENT_PROPERTY_DIR, errno);
    }
    
    mount("rootfs", "/", "rootfs", MS_REMOUNT|0, NULL);
    
    rc = property_get("persist.storages.planned_swap", value);
    if(rc && atoi(value)) {
	// if swapped
	property_set("persist.storages.swapped","1");
	property_set("ro.storage_list.override", "storage_list_swapped");
	symlink("/fstab.sd", "/fstab.qcom");
    } else {
	// if not swapped
	property_set("persist.storages.swapped","0");
	symlink("/fstab.int", "/fstab.qcom");
    }

    mount("rootfs", "/", "rootfs", MS_REMOUNT|MS_RDONLY, NULL);
    
    rc = property_get("persist.zram.planned_size", value);
    if(!rc) {
	  property_set("persist.zram.size", "128");
    } else {
	  if(atoi(value)) {
		property_set("persist.zram.size", value);
	  }
    }

    return;
}
