open Identifier
open Type

type mono_type_id = int

type mono_ty =
  | MonoUnit
  | MonoBoolean
  | MonoInteger of signedness * integer_width
  | MonoSingleFloat
  | MonoDoubleFloat
  | MonoNamedType of qident * mono_type_id
  | MonoArray of mono_ty
  | MonoReadRef of mono_ty
  | MonoWriteRef of mono_ty
  | MonoRawPointer of mono_ty

type mono_type_tbl = (qident * mono_ty list * mono_type_id) list

let empty_mono_type_tbl: mono_type_tbl = []
