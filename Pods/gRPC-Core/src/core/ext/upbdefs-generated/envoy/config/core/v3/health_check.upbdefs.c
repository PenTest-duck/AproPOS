/* This file was generated by upbc (the upb compiler) from the input
 * file:
 *
 *     envoy/config/core/v3/health_check.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include "upb/def.h"
#include "envoy/config/core/v3/health_check.upbdefs.h"
#include "envoy/config/core/v3/health_check.upb.h"

extern upb_def_init envoy_config_core_v3_base_proto_upbdefinit;
extern upb_def_init envoy_config_core_v3_event_service_config_proto_upbdefinit;
extern upb_def_init envoy_type_matcher_v3_string_proto_upbdefinit;
extern upb_def_init envoy_type_v3_http_proto_upbdefinit;
extern upb_def_init envoy_type_v3_range_proto_upbdefinit;
extern upb_def_init google_protobuf_any_proto_upbdefinit;
extern upb_def_init google_protobuf_duration_proto_upbdefinit;
extern upb_def_init google_protobuf_struct_proto_upbdefinit;
extern upb_def_init google_protobuf_wrappers_proto_upbdefinit;
extern upb_def_init udpa_annotations_status_proto_upbdefinit;
extern upb_def_init udpa_annotations_versioning_proto_upbdefinit;
extern upb_def_init validate_validate_proto_upbdefinit;
static const char descriptor[4221] = {'\n', '\'', 'e', 'n', 'v', 'o', 'y', '/', 'c', 'o', 'n', 'f', 'i', 'g', '/', 'c', 'o', 'r', 'e', '/', 'v', '3', '/', 'h', 'e', 
'a', 'l', 't', 'h', '_', 'c', 'h', 'e', 'c', 'k', '.', 'p', 'r', 'o', 't', 'o', '\022', '\024', 'e', 'n', 'v', 'o', 'y', '.', 'c', 
'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '\032', '\037', 'e', 'n', 'v', 'o', 'y', '/', 'c', 'o', 'n', 'f', 
'i', 'g', '/', 'c', 'o', 'r', 'e', '/', 'v', '3', '/', 'b', 'a', 's', 'e', '.', 'p', 'r', 'o', 't', 'o', '\032', '/', 'e', 'n', 
'v', 'o', 'y', '/', 'c', 'o', 'n', 'f', 'i', 'g', '/', 'c', 'o', 'r', 'e', '/', 'v', '3', '/', 'e', 'v', 'e', 'n', 't', '_', 
's', 'e', 'r', 'v', 'i', 'c', 'e', '_', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'p', 'r', 'o', 't', 'o', '\032', '\"', 'e', 'n', 'v', 
'o', 'y', '/', 't', 'y', 'p', 'e', '/', 'm', 'a', 't', 'c', 'h', 'e', 'r', '/', 'v', '3', '/', 's', 't', 'r', 'i', 'n', 'g', 
'.', 'p', 'r', 'o', 't', 'o', '\032', '\030', 'e', 'n', 'v', 'o', 'y', '/', 't', 'y', 'p', 'e', '/', 'v', '3', '/', 'h', 't', 't', 
'p', '.', 'p', 'r', 'o', 't', 'o', '\032', '\031', 'e', 'n', 'v', 'o', 'y', '/', 't', 'y', 'p', 'e', '/', 'v', '3', '/', 'r', 'a', 
'n', 'g', 'e', '.', 'p', 'r', 'o', 't', 'o', '\032', '\031', 'g', 'o', 'o', 'g', 'l', 'e', '/', 'p', 'r', 'o', 't', 'o', 'b', 'u', 
'f', '/', 'a', 'n', 'y', '.', 'p', 'r', 'o', 't', 'o', '\032', '\036', 'g', 'o', 'o', 'g', 'l', 'e', '/', 'p', 'r', 'o', 't', 'o', 
'b', 'u', 'f', '/', 'd', 'u', 'r', 'a', 't', 'i', 'o', 'n', '.', 'p', 'r', 'o', 't', 'o', '\032', '\034', 'g', 'o', 'o', 'g', 'l', 
'e', '/', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '/', 's', 't', 'r', 'u', 'c', 't', '.', 'p', 'r', 'o', 't', 'o', '\032', '\036', 
'g', 'o', 'o', 'g', 'l', 'e', '/', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '/', 'w', 'r', 'a', 'p', 'p', 'e', 'r', 's', '.', 
'p', 'r', 'o', 't', 'o', '\032', '\035', 'u', 'd', 'p', 'a', '/', 'a', 'n', 'n', 'o', 't', 'a', 't', 'i', 'o', 'n', 's', '/', 's', 
't', 'a', 't', 'u', 's', '.', 'p', 'r', 'o', 't', 'o', '\032', '!', 'u', 'd', 'p', 'a', '/', 'a', 'n', 'n', 'o', 't', 'a', 't', 
'i', 'o', 'n', 's', '/', 'v', 'e', 'r', 's', 'i', 'o', 'n', 'i', 'n', 'g', '.', 'p', 'r', 'o', 't', 'o', '\032', '\027', 'v', 'a', 
'l', 'i', 'd', 'a', 't', 'e', '/', 'v', 'a', 'l', 'i', 'd', 'a', 't', 'e', '.', 'p', 'r', 'o', 't', 'o', '\"', '\220', '\034', '\n', 
'\013', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '\022', '?', '\n', '\007', 't', 'i', 'm', 'e', 'o', 'u', 't', '\030', '\001', 
' ', '\001', '(', '\013', '2', '\031', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'D', 'u', 
'r', 'a', 't', 'i', 'o', 'n', 'B', '\n', '\372', 'B', '\007', '\252', '\001', '\004', '\010', '\001', '*', '\000', 'R', '\007', 't', 'i', 'm', 'e', 'o', 
'u', 't', '\022', 'A', '\n', '\010', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\030', '\002', ' ', '\001', '(', '\013', '2', '\031', '.', 'g', 'o', 
'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'D', 'u', 'r', 'a', 't', 'i', 'o', 'n', 'B', '\n', '\372', 
'B', '\007', '\252', '\001', '\004', '\010', '\001', '*', '\000', 'R', '\010', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\022', '@', '\n', '\016', 'i', 'n', 
'i', 't', 'i', 'a', 'l', '_', 'j', 'i', 't', 't', 'e', 'r', '\030', '\024', ' ', '\001', '(', '\013', '2', '\031', '.', 'g', 'o', 'o', 'g', 
'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'D', 'u', 'r', 'a', 't', 'i', 'o', 'n', 'R', '\r', 'i', 'n', 'i', 
't', 'i', 'a', 'l', 'J', 'i', 't', 't', 'e', 'r', '\022', 'B', '\n', '\017', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', '_', 'j', 'i', 
't', 't', 'e', 'r', '\030', '\003', ' ', '\001', '(', '\013', '2', '\031', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 
'b', 'u', 'f', '.', 'D', 'u', 'r', 'a', 't', 'i', 'o', 'n', 'R', '\016', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', 'J', 'i', 't', 
't', 'e', 'r', '\022', '6', '\n', '\027', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', '_', 'j', 'i', 't', 't', 'e', 'r', '_', 'p', 'e', 
'r', 'c', 'e', 'n', 't', '\030', '\022', ' ', '\001', '(', '\r', 'R', '\025', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', 'J', 'i', 't', 't', 
'e', 'r', 'P', 'e', 'r', 'c', 'e', 'n', 't', '\022', 'W', '\n', '\023', 'u', 'n', 'h', 'e', 'a', 'l', 't', 'h', 'y', '_', 't', 'h', 
'r', 'e', 's', 'h', 'o', 'l', 'd', '\030', '\004', ' ', '\001', '(', '\013', '2', '\034', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 
'o', 't', 'o', 'b', 'u', 'f', '.', 'U', 'I', 'n', 't', '3', '2', 'V', 'a', 'l', 'u', 'e', 'B', '\010', '\372', 'B', '\005', '\212', '\001', 
'\002', '\020', '\001', 'R', '\022', 'u', 'n', 'h', 'e', 'a', 'l', 't', 'h', 'y', 'T', 'h', 'r', 'e', 's', 'h', 'o', 'l', 'd', '\022', 'S', 
'\n', '\021', 'h', 'e', 'a', 'l', 't', 'h', 'y', '_', 't', 'h', 'r', 'e', 's', 'h', 'o', 'l', 'd', '\030', '\005', ' ', '\001', '(', '\013', 
'2', '\034', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'U', 'I', 'n', 't', '3', '2', 
'V', 'a', 'l', 'u', 'e', 'B', '\010', '\372', 'B', '\005', '\212', '\001', '\002', '\020', '\001', 'R', '\020', 'h', 'e', 'a', 'l', 't', 'h', 'y', 'T', 
'h', 'r', 'e', 's', 'h', 'o', 'l', 'd', '\022', '7', '\n', '\010', 'a', 'l', 't', '_', 'p', 'o', 'r', 't', '\030', '\006', ' ', '\001', '(', 
'\013', '2', '\034', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'U', 'I', 'n', 't', '3', 
'2', 'V', 'a', 'l', 'u', 'e', 'R', '\007', 'a', 'l', 't', 'P', 'o', 'r', 't', '\022', 'E', '\n', '\020', 'r', 'e', 'u', 's', 'e', '_', 
'c', 'o', 'n', 'n', 'e', 'c', 't', 'i', 'o', 'n', '\030', '\007', ' ', '\001', '(', '\013', '2', '\032', '.', 'g', 'o', 'o', 'g', 'l', 'e', 
'.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'B', 'o', 'o', 'l', 'V', 'a', 'l', 'u', 'e', 'R', '\017', 'r', 'e', 'u', 's', 
'e', 'C', 'o', 'n', 'n', 'e', 'c', 't', 'i', 'o', 'n', '\022', '_', '\n', '\021', 'h', 't', 't', 'p', '_', 'h', 'e', 'a', 'l', 't', 
'h', '_', 'c', 'h', 'e', 'c', 'k', '\030', '\010', ' ', '\001', '(', '\013', '2', '1', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 
'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'H', 
't', 't', 'p', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', 'H', '\000', 'R', '\017', 'h', 't', 't', 'p', 'H', 'e', 'a', 
'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '\022', '\\', '\n', '\020', 't', 'c', 'p', '_', 'h', 'e', 'a', 'l', 't', 'h', '_', 'c', 'h', 
'e', 'c', 'k', '\030', '\t', ' ', '\001', '(', '\013', '2', '0', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 
'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'T', 'c', 'p', 'H', 'e', 
'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', 'H', '\000', 'R', '\016', 't', 'c', 'p', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 
'c', 'k', '\022', '_', '\n', '\021', 'g', 'r', 'p', 'c', '_', 'h', 'e', 'a', 'l', 't', 'h', '_', 'c', 'h', 'e', 'c', 'k', '\030', '\013', 
' ', '\001', '(', '\013', '2', '1', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 
'v', '3', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'G', 'r', 'p', 'c', 'H', 'e', 'a', 'l', 't', 'h', 
'C', 'h', 'e', 'c', 'k', 'H', '\000', 'R', '\017', 'g', 'r', 'p', 'c', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '\022', 
'e', '\n', '\023', 'c', 'u', 's', 't', 'o', 'm', '_', 'h', 'e', 'a', 'l', 't', 'h', '_', 'c', 'h', 'e', 'c', 'k', '\030', '\r', ' ', 
'\001', '(', '\013', '2', '3', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', 
'3', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'C', 'u', 's', 't', 'o', 'm', 'H', 'e', 'a', 'l', 't', 
'h', 'C', 'h', 'e', 'c', 'k', 'H', '\000', 'R', '\021', 'c', 'u', 's', 't', 'o', 'm', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 
'c', 'k', '\022', 'S', '\n', '\023', 'n', 'o', '_', 't', 'r', 'a', 'f', 'f', 'i', 'c', '_', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', 
'\030', '\014', ' ', '\001', '(', '\013', '2', '\031', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 
'D', 'u', 'r', 'a', 't', 'i', 'o', 'n', 'B', '\010', '\372', 'B', '\005', '\252', '\001', '\002', '*', '\000', 'R', '\021', 'n', 'o', 'T', 'r', 'a', 
'f', 'f', 'i', 'c', 'I', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\022', 'b', '\n', '\033', 'n', 'o', '_', 't', 'r', 'a', 'f', 'f', 'i', 
'c', '_', 'h', 'e', 'a', 'l', 't', 'h', 'y', '_', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\030', '\030', ' ', '\001', '(', '\013', '2', 
'\031', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'D', 'u', 'r', 'a', 't', 'i', 'o', 
'n', 'B', '\010', '\372', 'B', '\005', '\252', '\001', '\002', '*', '\000', 'R', '\030', 'n', 'o', 'T', 'r', 'a', 'f', 'f', 'i', 'c', 'H', 'e', 'a', 
'l', 't', 'h', 'y', 'I', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\022', 'R', '\n', '\022', 'u', 'n', 'h', 'e', 'a', 'l', 't', 'h', 'y', 
'_', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\030', '\016', ' ', '\001', '(', '\013', '2', '\031', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 
'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'D', 'u', 'r', 'a', 't', 'i', 'o', 'n', 'B', '\010', '\372', 'B', '\005', '\252', '\001', '\002', 
'*', '\000', 'R', '\021', 'u', 'n', 'h', 'e', 'a', 'l', 't', 'h', 'y', 'I', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\022', '[', '\n', '\027', 
'u', 'n', 'h', 'e', 'a', 'l', 't', 'h', 'y', '_', 'e', 'd', 'g', 'e', '_', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\030', '\017', 
' ', '\001', '(', '\013', '2', '\031', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'D', 'u', 
'r', 'a', 't', 'i', 'o', 'n', 'B', '\010', '\372', 'B', '\005', '\252', '\001', '\002', '*', '\000', 'R', '\025', 'u', 'n', 'h', 'e', 'a', 'l', 't', 
'h', 'y', 'E', 'd', 'g', 'e', 'I', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\022', 'W', '\n', '\025', 'h', 'e', 'a', 'l', 't', 'h', 'y', 
'_', 'e', 'd', 'g', 'e', '_', 'i', 'n', 't', 'e', 'r', 'v', 'a', 'l', '\030', '\020', ' ', '\001', '(', '\013', '2', '\031', '.', 'g', 'o', 
'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 'D', 'u', 'r', 'a', 't', 'i', 'o', 'n', 'B', '\010', '\372', 
'B', '\005', '\252', '\001', '\002', '*', '\000', 'R', '\023', 'h', 'e', 'a', 'l', 't', 'h', 'y', 'E', 'd', 'g', 'e', 'I', 'n', 't', 'e', 'r', 
'v', 'a', 'l', '\022', '$', '\n', '\016', 'e', 'v', 'e', 'n', 't', '_', 'l', 'o', 'g', '_', 'p', 'a', 't', 'h', '\030', '\021', ' ', '\001', 
'(', '\t', 'R', '\014', 'e', 'v', 'e', 'n', 't', 'L', 'o', 'g', 'P', 'a', 't', 'h', '\022', 'M', '\n', '\r', 'e', 'v', 'e', 'n', 't', 
'_', 's', 'e', 'r', 'v', 'i', 'c', 'e', '\030', '\026', ' ', '\001', '(', '\013', '2', '(', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 
'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'E', 'v', 'e', 'n', 't', 'S', 'e', 'r', 'v', 'i', 'c', 'e', 
'C', 'o', 'n', 'f', 'i', 'g', 'R', '\014', 'e', 'v', 'e', 'n', 't', 'S', 'e', 'r', 'v', 'i', 'c', 'e', '\022', 'F', '\n', ' ', 'a', 
'l', 'w', 'a', 'y', 's', '_', 'l', 'o', 'g', '_', 'h', 'e', 'a', 'l', 't', 'h', '_', 'c', 'h', 'e', 'c', 'k', '_', 'f', 'a', 
'i', 'l', 'u', 'r', 'e', 's', '\030', '\023', ' ', '\001', '(', '\010', 'R', '\034', 'a', 'l', 'w', 'a', 'y', 's', 'L', 'o', 'g', 'H', 'e', 
'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', 'F', 'a', 'i', 'l', 'u', 'r', 'e', 's', '\022', 'M', '\n', '\013', 't', 'l', 's', '_', 
'o', 'p', 't', 'i', 'o', 'n', 's', '\030', '\025', ' ', '\001', '(', '\013', '2', ',', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 
'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'T', 
'l', 's', 'O', 'p', 't', 'i', 'o', 'n', 's', 'R', '\n', 't', 'l', 's', 'O', 'p', 't', 'i', 'o', 'n', 's', '\022', '^', '\n', '\037', 
't', 'r', 'a', 'n', 's', 'p', 'o', 'r', 't', '_', 's', 'o', 'c', 'k', 'e', 't', '_', 'm', 'a', 't', 'c', 'h', '_', 'c', 'r', 
'i', 't', 'e', 'r', 'i', 'a', '\030', '\027', ' ', '\001', '(', '\013', '2', '\027', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 
't', 'o', 'b', 'u', 'f', '.', 'S', 't', 'r', 'u', 'c', 't', 'R', '\034', 't', 'r', 'a', 'n', 's', 'p', 'o', 'r', 't', 'S', 'o', 
'c', 'k', 'e', 't', 'M', 'a', 't', 'c', 'h', 'C', 'r', 'i', 't', 'e', 'r', 'i', 'a', '\032', '\200', '\001', '\n', '\007', 'P', 'a', 'y', 
'l', 'o', 'a', 'd', '\022', '\035', '\n', '\004', 't', 'e', 'x', 't', '\030', '\001', ' ', '\001', '(', '\t', 'B', '\007', '\372', 'B', '\004', 'r', '\002', 
'\020', '\001', 'H', '\000', 'R', '\004', 't', 'e', 'x', 't', '\022', '\030', '\n', '\006', 'b', 'i', 'n', 'a', 'r', 'y', '\030', '\002', ' ', '\001', '(', 
'\014', 'H', '\000', 'R', '\006', 'b', 'i', 'n', 'a', 'r', 'y', ':', ',', '\232', '\305', '\210', '\036', '\'', '\n', '%', 'e', 'n', 'v', 'o', 'y', 
'.', 'a', 'p', 'i', '.', 'v', '2', '.', 'c', 'o', 'r', 'e', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 
'P', 'a', 'y', 'l', 'o', 'a', 'd', 'B', '\016', '\n', '\007', 'p', 'a', 'y', 'l', 'o', 'a', 'd', '\022', '\003', '\370', 'B', '\001', '\032', '\252', 
'\006', '\n', '\017', 'H', 't', 't', 'p', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '\022', '\037', '\n', '\004', 'h', 'o', 's', 
't', '\030', '\001', ' ', '\001', '(', '\t', 'B', '\013', '\372', 'B', '\010', 'r', '\006', '\300', '\001', '\002', '\310', '\001', '\000', 'R', '\004', 'h', 'o', 's', 
't', '\022', '!', '\n', '\004', 'p', 'a', 't', 'h', '\030', '\002', ' ', '\001', '(', '\t', 'B', '\r', '\372', 'B', '\n', 'r', '\010', '\020', '\001', '\300', 
'\001', '\002', '\310', '\001', '\000', 'R', '\004', 'p', 'a', 't', 'h', '\022', '=', '\n', '\004', 's', 'e', 'n', 'd', '\030', '\003', ' ', '\001', '(', '\013', 
'2', ')', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'H', 
'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'P', 'a', 'y', 'l', 'o', 'a', 'd', 'R', '\004', 's', 'e', 'n', 'd', '\022', 
'C', '\n', '\007', 'r', 'e', 'c', 'e', 'i', 'v', 'e', '\030', '\004', ' ', '\001', '(', '\013', '2', ')', '.', 'e', 'n', 'v', 'o', 'y', '.', 
'c', 'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 
'k', '.', 'P', 'a', 'y', 'l', 'o', 'a', 'd', 'R', '\007', 'r', 'e', 'c', 'e', 'i', 'v', 'e', '\022', 'g', '\n', '\026', 'r', 'e', 'q', 
'u', 'e', 's', 't', '_', 'h', 'e', 'a', 'd', 'e', 'r', 's', '_', 't', 'o', '_', 'a', 'd', 'd', '\030', '\006', ' ', '\003', '(', '\013', 
'2', '\'', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'H', 
'e', 'a', 'd', 'e', 'r', 'V', 'a', 'l', 'u', 'e', 'O', 'p', 't', 'i', 'o', 'n', 'B', '\t', '\372', 'B', '\006', '\222', '\001', '\003', '\020', 
'\350', '\007', 'R', '\023', 'r', 'e', 'q', 'u', 'e', 's', 't', 'H', 'e', 'a', 'd', 'e', 'r', 's', 'T', 'o', 'A', 'd', 'd', '\022', 'K', 
'\n', '\031', 'r', 'e', 'q', 'u', 'e', 's', 't', '_', 'h', 'e', 'a', 'd', 'e', 'r', 's', '_', 't', 'o', '_', 'r', 'e', 'm', 'o', 
'v', 'e', '\030', '\010', ' ', '\003', '(', '\t', 'B', '\020', '\372', 'B', '\r', '\222', '\001', '\n', '\"', '\010', 'r', '\006', '\300', '\001', '\001', '\310', '\001', 
'\000', 'R', '\026', 'r', 'e', 'q', 'u', 'e', 's', 't', 'H', 'e', 'a', 'd', 'e', 'r', 's', 'T', 'o', 'R', 'e', 'm', 'o', 'v', 'e', 
'\022', 'F', '\n', '\021', 'e', 'x', 'p', 'e', 'c', 't', 'e', 'd', '_', 's', 't', 'a', 't', 'u', 's', 'e', 's', '\030', '\t', ' ', '\003', 
'(', '\013', '2', '\031', '.', 'e', 'n', 'v', 'o', 'y', '.', 't', 'y', 'p', 'e', '.', 'v', '3', '.', 'I', 'n', 't', '6', '4', 'R', 
'a', 'n', 'g', 'e', 'R', '\020', 'e', 'x', 'p', 'e', 'c', 't', 'e', 'd', 'S', 't', 'a', 't', 'u', 's', 'e', 's', '\022', 'H', '\n', 
'\022', 'r', 'e', 't', 'r', 'i', 'a', 'b', 'l', 'e', '_', 's', 't', 'a', 't', 'u', 's', 'e', 's', '\030', '\014', ' ', '\003', '(', '\013', 
'2', '\031', '.', 'e', 'n', 'v', 'o', 'y', '.', 't', 'y', 'p', 'e', '.', 'v', '3', '.', 'I', 'n', 't', '6', '4', 'R', 'a', 'n', 
'g', 'e', 'R', '\021', 'r', 'e', 't', 'r', 'i', 'a', 'b', 'l', 'e', 'S', 't', 'a', 't', 'u', 's', 'e', 's', '\022', 'T', '\n', '\021', 
'c', 'o', 'd', 'e', 'c', '_', 'c', 'l', 'i', 'e', 'n', 't', '_', 't', 'y', 'p', 'e', '\030', '\n', ' ', '\001', '(', '\016', '2', '\036', 
'.', 'e', 'n', 'v', 'o', 'y', '.', 't', 'y', 'p', 'e', '.', 'v', '3', '.', 'C', 'o', 'd', 'e', 'c', 'C', 'l', 'i', 'e', 'n', 
't', 'T', 'y', 'p', 'e', 'B', '\010', '\372', 'B', '\005', '\202', '\001', '\002', '\020', '\001', 'R', '\017', 'c', 'o', 'd', 'e', 'c', 'C', 'l', 'i', 
'e', 'n', 't', 'T', 'y', 'p', 'e', '\022', 'V', '\n', '\024', 's', 'e', 'r', 'v', 'i', 'c', 'e', '_', 'n', 'a', 'm', 'e', '_', 'm', 
'a', 't', 'c', 'h', 'e', 'r', '\030', '\013', ' ', '\001', '(', '\013', '2', '$', '.', 'e', 'n', 'v', 'o', 'y', '.', 't', 'y', 'p', 'e', 
'.', 'm', 'a', 't', 'c', 'h', 'e', 'r', '.', 'v', '3', '.', 'S', 't', 'r', 'i', 'n', 'g', 'M', 'a', 't', 'c', 'h', 'e', 'r', 
'R', '\022', 's', 'e', 'r', 'v', 'i', 'c', 'e', 'N', 'a', 'm', 'e', 'M', 'a', 't', 'c', 'h', 'e', 'r', ':', '4', '\232', '\305', '\210', 
'\036', '/', '\n', '-', 'e', 'n', 'v', 'o', 'y', '.', 'a', 'p', 'i', '.', 'v', '2', '.', 'c', 'o', 'r', 'e', '.', 'H', 'e', 'a', 
'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'H', 't', 't', 'p', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', 'J', 
'\004', '\010', '\005', '\020', '\006', 'J', '\004', '\010', '\007', '\020', '\010', 'R', '\014', 's', 'e', 'r', 'v', 'i', 'c', 'e', '_', 'n', 'a', 'm', 'e', 
'R', '\t', 'u', 's', 'e', '_', 'h', 't', 't', 'p', '2', '\032', '\311', '\001', '\n', '\016', 'T', 'c', 'p', 'H', 'e', 'a', 'l', 't', 'h', 
'C', 'h', 'e', 'c', 'k', '\022', '=', '\n', '\004', 's', 'e', 'n', 'd', '\030', '\001', ' ', '\001', '(', '\013', '2', ')', '.', 'e', 'n', 'v', 
'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 
'h', 'e', 'c', 'k', '.', 'P', 'a', 'y', 'l', 'o', 'a', 'd', 'R', '\004', 's', 'e', 'n', 'd', '\022', 'C', '\n', '\007', 'r', 'e', 'c', 
'e', 'i', 'v', 'e', '\030', '\002', ' ', '\003', '(', '\013', '2', ')', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', 
'.', 'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'P', 'a', 'y', 'l', 
'o', 'a', 'd', 'R', '\007', 'r', 'e', 'c', 'e', 'i', 'v', 'e', ':', '3', '\232', '\305', '\210', '\036', '.', '\n', ',', 'e', 'n', 'v', 'o', 
'y', '.', 'a', 'p', 'i', '.', 'v', '2', '.', 'c', 'o', 'r', 'e', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', 
'.', 'T', 'c', 'p', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '\032', '[', '\n', '\020', 'R', 'e', 'd', 'i', 's', 'H', 
'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '\022', '\020', '\n', '\003', 'k', 'e', 'y', '\030', '\001', ' ', '\001', '(', '\t', 'R', '\003', 
'k', 'e', 'y', ':', '5', '\232', '\305', '\210', '\036', '0', '\n', '.', 'e', 'n', 'v', 'o', 'y', '.', 'a', 'p', 'i', '.', 'v', '2', '.', 
'c', 'o', 'r', 'e', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'R', 'e', 'd', 'i', 's', 'H', 'e', 'a', 
'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '\032', '\225', '\001', '\n', '\017', 'G', 'r', 'p', 'c', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 
'e', 'c', 'k', '\022', '!', '\n', '\014', 's', 'e', 'r', 'v', 'i', 'c', 'e', '_', 'n', 'a', 'm', 'e', '\030', '\001', ' ', '\001', '(', '\t', 
'R', '\013', 's', 'e', 'r', 'v', 'i', 'c', 'e', 'N', 'a', 'm', 'e', '\022', ')', '\n', '\t', 'a', 'u', 't', 'h', 'o', 'r', 'i', 't', 
'y', '\030', '\002', ' ', '\001', '(', '\t', 'B', '\013', '\372', 'B', '\010', 'r', '\006', '\300', '\001', '\002', '\310', '\001', '\000', 'R', '\t', 'a', 'u', 't', 
'h', 'o', 'r', 'i', 't', 'y', ':', '4', '\232', '\305', '\210', '\036', '/', '\n', '-', 'e', 'n', 'v', 'o', 'y', '.', 'a', 'p', 'i', '.', 
'v', '2', '.', 'c', 'o', 'r', 'e', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'G', 'r', 'p', 'c', 'H', 
'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '\032', '\300', '\001', '\n', '\021', 'C', 'u', 's', 't', 'o', 'm', 'H', 'e', 'a', 'l', 
't', 'h', 'C', 'h', 'e', 'c', 'k', '\022', '\033', '\n', '\004', 'n', 'a', 'm', 'e', '\030', '\001', ' ', '\001', '(', '\t', 'B', '\007', '\372', 'B', 
'\004', 'r', '\002', '\020', '\001', 'R', '\004', 'n', 'a', 'm', 'e', '\022', '9', '\n', '\014', 't', 'y', 'p', 'e', 'd', '_', 'c', 'o', 'n', 'f', 
'i', 'g', '\030', '\003', ' ', '\001', '(', '\013', '2', '\024', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 
'f', '.', 'A', 'n', 'y', 'H', '\000', 'R', '\013', 't', 'y', 'p', 'e', 'd', 'C', 'o', 'n', 'f', 'i', 'g', ':', '6', '\232', '\305', '\210', 
'\036', '1', '\n', '/', 'e', 'n', 'v', 'o', 'y', '.', 'a', 'p', 'i', '.', 'v', '2', '.', 'c', 'o', 'r', 'e', '.', 'H', 'e', 'a', 
'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'C', 'u', 's', 't', 'o', 'm', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 
'k', 'B', '\r', '\n', '\013', 'c', 'o', 'n', 'f', 'i', 'g', '_', 't', 'y', 'p', 'e', 'J', '\004', '\010', '\002', '\020', '\003', 'R', '\006', 'c', 
'o', 'n', 'f', 'i', 'g', '\032', 'd', '\n', '\n', 'T', 'l', 's', 'O', 'p', 't', 'i', 'o', 'n', 's', '\022', '%', '\n', '\016', 'a', 'l', 
'p', 'n', '_', 'p', 'r', 'o', 't', 'o', 'c', 'o', 'l', 's', '\030', '\001', ' ', '\003', '(', '\t', 'R', '\r', 'a', 'l', 'p', 'n', 'P', 
'r', 'o', 't', 'o', 'c', 'o', 'l', 's', ':', '/', '\232', '\305', '\210', '\036', '*', '\n', '(', 'e', 'n', 'v', 'o', 'y', '.', 'a', 'p', 
'i', '.', 'v', '2', '.', 'c', 'o', 'r', 'e', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', '.', 'T', 'l', 's', 
'O', 'p', 't', 'i', 'o', 'n', 's', ':', '$', '\232', '\305', '\210', '\036', '\037', '\n', '\035', 'e', 'n', 'v', 'o', 'y', '.', 'a', 'p', 'i', 
'.', 'v', '2', '.', 'c', 'o', 'r', 'e', '.', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', 'B', '\025', '\n', '\016', 'h', 
'e', 'a', 'l', 't', 'h', '_', 'c', 'h', 'e', 'c', 'k', 'e', 'r', '\022', '\003', '\370', 'B', '\001', 'J', '\004', '\010', '\n', '\020', '\013', '*', 
'`', '\n', '\014', 'H', 'e', 'a', 'l', 't', 'h', 'S', 't', 'a', 't', 'u', 's', '\022', '\013', '\n', '\007', 'U', 'N', 'K', 'N', 'O', 'W', 
'N', '\020', '\000', '\022', '\013', '\n', '\007', 'H', 'E', 'A', 'L', 'T', 'H', 'Y', '\020', '\001', '\022', '\r', '\n', '\t', 'U', 'N', 'H', 'E', 'A', 
'L', 'T', 'H', 'Y', '\020', '\002', '\022', '\014', '\n', '\010', 'D', 'R', 'A', 'I', 'N', 'I', 'N', 'G', '\020', '\003', '\022', '\013', '\n', '\007', 'T', 
'I', 'M', 'E', 'O', 'U', 'T', '\020', '\004', '\022', '\014', '\n', '\010', 'D', 'E', 'G', 'R', 'A', 'D', 'E', 'D', '\020', '\005', 'B', '@', '\n', 
'\"', 'i', 'o', '.', 'e', 'n', 'v', 'o', 'y', 'p', 'r', 'o', 'x', 'y', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 
'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', 'B', '\020', 'H', 'e', 'a', 'l', 't', 'h', 'C', 'h', 'e', 'c', 'k', 'P', 'r', 
'o', 't', 'o', 'P', '\001', '\272', '\200', '\310', '\321', '\006', '\002', '\020', '\002', 'b', '\006', 'p', 'r', 'o', 't', 'o', '3', 
};

static upb_def_init *deps[13] = {
  &envoy_config_core_v3_base_proto_upbdefinit,
  &envoy_config_core_v3_event_service_config_proto_upbdefinit,
  &envoy_type_matcher_v3_string_proto_upbdefinit,
  &envoy_type_v3_http_proto_upbdefinit,
  &envoy_type_v3_range_proto_upbdefinit,
  &google_protobuf_any_proto_upbdefinit,
  &google_protobuf_duration_proto_upbdefinit,
  &google_protobuf_struct_proto_upbdefinit,
  &google_protobuf_wrappers_proto_upbdefinit,
  &udpa_annotations_status_proto_upbdefinit,
  &udpa_annotations_versioning_proto_upbdefinit,
  &validate_validate_proto_upbdefinit,
  NULL
};

upb_def_init envoy_config_core_v3_health_check_proto_upbdefinit = {
  deps,
  &envoy_config_core_v3_health_check_proto_upb_file_layout,
  "envoy/config/core/v3/health_check.proto",
  UPB_STRVIEW_INIT(descriptor, 4221)
};
