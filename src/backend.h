// Copyright 2015 Google Inc. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef PINDROP_BACKEND_H_
#define PINDROP_BACKEND_H_

namespace pindrop {

class AudioConfig;

class Backend {
 public:
  Backend();
  ~Backend();

  bool Initialize(const AudioConfig* config);

 private:
  bool initialized_;
};

}  // namespace pindrop

#endif  // PINDROP_BACKEND_H_

