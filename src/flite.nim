#***********************************************************************
#
#                  Language Technologies Institute
#                     Carnegie Mellon University
#                        Copyright (c) 1999
#                        All Rights Reserved.
#
#  Permission is hereby granted, free of charge, to use and distribute
#  this software and its documentation without restriction, including
#  without limitation the rights to use, copy, modify, merge, publish,
#  distribute, sublicense, and/or sell copies of this work, and to
#  permit persons to whom this work is furnished to do so, subject to
#  the following conditions:
#   1. The code must retain the above copyright notice, this list of
#      conditions and the following disclaimer.
#   2. Any modifications must be clearly marked as such.
#   3. Original authors' names are not deleted.
#   4. The authors' names are not used to endorse or promote products
#      derived from this software without specific prior written
#      permission.
#
#  CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK
#  DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
#  ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT
#  SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE
#  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
#  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
#  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
#  THIS SOFTWARE.
#
#***********************************************************************
#             Author:  Alan W Black (awb@cs.cmu.edu)
#               Date:  December 1999
#***********************************************************************
#
#  Light weight run-time speech synthesis system, public API
#
#***********************************************************************

when defined(Windows):
  const LibName* = "flite.dll"
elif defined(Linux):
  const LibName* = "libflite.so"
elif defined(macosx):
  const LibName* = "libflite.dylib"

{.push callconv: cdecl, dynlib: LibName.}

type
  Voice* = ptr object
    name*: cstring
    features*: Features
    ffunctions*: Features

  Features* = ptr object
  Utterance* = ptr object
    features*: Features
    ffunctions*: Features
    relations*: Features
  UttFunc* = proc (i: Utterance): Utterance

  Wave* = ptr object
    kind*: cstring
    sampleRate*: cint
    numSamples*: cint
    numChannels*: cint
    samples*: ptr cshort

  WaveHeader* = object
    kind*: cstring
    hsize*: cint
    numBytes*: cint
    sampleRate*: cint
    numSamples*: cint
    numChannels*: cint



# Public functions
proc fliteInit*(): cint {.
  importc: "flite_init" .}

# General top level functions
proc fliteVoiceSelect*(name: cstring): Voice {.
  importc: "flite_voice_select" .}

proc fliteFileToSpeech*(filename: cstring; voice: Voice; outtype: cstring): cfloat {.
  importc: "flite_file_to_speech" .}

proc fliteTextToSpeech*(text: cstring; voice: Voice; outtype: cstring): cfloat {.
  importc: "flite_text_to_speech" .}

proc flitePhonesToSpeech*(text: cstring; voice: Voice; outtype: cstring): cfloat {.
  importc: "flite_phones_to_speech" .}

proc fliteSsmlToSpeech*(filename: cstring; voice: Voice; outtype: cstring): cfloat {.
  importc: "flite_ssml_to_speech" .}

proc fliteVoiceAddLexAddenda*(v: Voice; lexfile: cstring): cint {.
  importc: "flite_voice_add_lex_addenda" .}

# Lower lever user functions
proc fliteTextToWave*(text: cstring; voice: Voice): Wave {.
  importc: "flite_text_to_wave" .}

proc fliteSynthText*(text: cstring; voice: Voice): Utterance {.
  importc: "flite_synth_text" .}

proc fliteSynthPhones*(phones: cstring; voice: Voice): Utterance {.
  importc: "flite_synth_phones" .}

proc fliteDoSynth*(u: Utterance; voice: Voice; synth: UttFunc): Utterance {.
  importc: "flite_do_synth" .}

proc fliteProcessOutput*(u: Utterance; outtype: cstring; append: cint): cfloat {.
  importc: "flite_process_output" .}

# flite public export wrappers for features access
proc getInt*(f: Features; name: cstring; def: cint): cint {.
  importc: "flite_get_param_int" .}

proc getFloat*(f: Features; name: cstring; def: cfloat): cfloat {.
  importc: "flite_get_param_float" .}

proc getString*(f: Features; name: cstring; def: cstring): cstring {.
  importc: "flite_get_param_string" .}

proc setInt*(f: Features; name: cstring; v: cint) {.
  importc: "flite_feat_set_int" .}

proc setFloat*(f: Features; name: cstring; v: cfloat) {.
  importc: "flite_feat_set_float" .}

proc setString*(f: Features; name: cstring; v: cstring) {.
  importc: "flite_feat_set_string" .}

proc remove*(f: Features; name: cstring): cint {.
  importc: "flite_feat_remove" .}


#Wave functions

proc `[]`*(self: Wave, index: int): cshort =
  cast[ptr cshort](cast[int](self.samples) + index)[]

proc newWave*(): Wave {.
  importc: "new_wave" .}

proc copyWave*(w: Wave): Wave {.
  importc: "copy_wave" .}

proc delete*(val: Wave) {.
  importc: "delete_wave" .}

proc concat*(dest: Wave; src: Wave): Wave {.
  importc: "concat_wave" .}

proc save*(w: Wave; filename: cstring; kind: cstring): cint {.
  importc: "cst_wave_save" .}

proc saveRiff*(w: Wave; filename: cstring): cint {.
  importc: "cst_wave_save_riff" .}

proc saveRaw*(w: Wave; filename: cstring): cint {.
  importc: "cst_wave_save_raw" .}

proc appendRiff*(w: Wave; filename: cstring): cint {.
  importc: "cst_wave_append_riff" .}

proc load*(w: Wave; filename: cstring; kind: cstring): cint {.
  importc: "cst_wave_load" .}

proc loadRiff*(w: Wave; filename: cstring): cint {.
  importc: "cst_wave_load_riff" .}

proc loadRaw*(w: Wave; filename: cstring; bo: cstring; sample_rate: cint): cint {.
  importc: "cst_wave_load_raw" .}

proc resize*(w: Wave; samples: cint; num_channels: cint) {.
  importc: "cst_wave_resize" .}

proc resample*(w: Wave; sample_rate: cint) {.
  importc: "cst_wave_resample" .}

proc rescale*(w: Wave; factor: cint) {.
  importc: "cst_wave_rescale" .}


{.pop.}
