# Copyright 2014 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := pindrop
LOCAL_ARM_MODE := arm
LOCAL_STATIC_LIBRARIES :=
LOCAL_SHARED_LIBRARIES := libmathfu SDL2 SDL2_mixer

PINDROP_RELATIVE_DIR := ..
PINDROP_DIR := $(LOCAL_PATH)/$(PINDROP_RELATIVE_DIR)

include $(PINDROP_DIR)/jni/android_config.mk
include $(DEPENDENCIES_FLATBUFFERS_DIR)/android/jni/include.mk

PINDROP_GENERATED_OUTPUT_DIR := $(PINDROP_DIR)/gen/include

LOCAL_EXPORT_C_INCLUDES := \
  $(PINDROP_DIR)/include \
  $(PINDROP_GENERATED_OUTPUT_DIR)

LOCAL_C_INCLUDES := \
  $(LOCAL_EXPORT_C_INCLUDES) \
  $(PINDROP_DIR)/src \
  $(DEPENDENCIES_FLATBUFFERS_DIR)/include \
  $(DEPENDENCIES_SDL_DIR) \
  $(DEPENDENCIES_SDL_DIR)/include \
  $(DEPENDENCIES_SDL_MIXER_DIR)

LOCAL_SRC_FILES := \
  $(PINDROP_RELATIVE_DIR)/src/audio_engine.cpp \
  $(PINDROP_RELATIVE_DIR)/src/backend.cpp \
  $(PINDROP_RELATIVE_DIR)/src/bus.cpp \
  $(PINDROP_RELATIVE_DIR)/src/channel.cpp \
  $(PINDROP_RELATIVE_DIR)/src/channel_internal_state.cpp \
  $(PINDROP_RELATIVE_DIR)/src/listener.cpp \
  $(PINDROP_RELATIVE_DIR)/src/main.cpp \
  $(PINDROP_RELATIVE_DIR)/src/ref_counter.cpp \
  $(PINDROP_RELATIVE_DIR)/src/sound.cpp \
  $(PINDROP_RELATIVE_DIR)/src/sound_bank.cpp \
  $(PINDROP_RELATIVE_DIR)/src/sound_collection.cpp

PINDROP_SCHEMA_DIR := $(PINDROP_DIR)/schemas
PINDROP_SCHEMA_INCLUDE_DIRS :=

PINDROP_SCHEMA_FILES := \
  $(PINDROP_SCHEMA_DIR)/audio_config.fbs \
  $(PINDROP_SCHEMA_DIR)/buses.fbs \
  $(PINDROP_SCHEMA_DIR)/sound_bank_def.fbs \
  $(PINDROP_SCHEMA_DIR)/sound_collection_def.fbs

ifeq (,$(PINDROP_RUN_ONCE))
PINDROP_RUN_ONCE := 1
$(call flatbuffers_header_build_rules, \
  $(PINDROP_SCHEMA_FILES), \
  $(PINDROP_SCHEMA_DIR), \
  $(PINDROP_GENERATED_OUTPUT_DIR), \
  $(PINDROP_SCHEMA_INCLUDE_DIRS), \
  $(LOCAL_SRC_FILES))
endif

include $(BUILD_STATIC_LIBRARY)

$(call import-add-path,$(DEPENDENCIES_FLATBUFFERS_DIR)/..)

$(call import-module,flatbuffers/android/jni)

$(call import-module,mathfu/jni)
