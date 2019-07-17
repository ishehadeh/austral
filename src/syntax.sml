(*
    Copyright 2018–2019 Fernando Borretti <fernando@borretti.me>

    This file is part of Austral.

    Austral is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Austral is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Austral.  If not, see <http://www.gnu.org/licenses/>.
*)

structure Syntax = struct
    type module_name = Name.module_name
    type identifier = Name.ident

    datatype module = Module of docstring * module_name * import list * definition list

         and import = Import of module_name * imported_name

         and imported_name = ImportedName of { name: identifier, rename: identifier }

         and definition = RecordDef of docstring * type_vis * identifier * type_params * slot list
                        | UnionDef of docstring * type_vis * identifier * type_params * union_case list
                        | FunctionDef of docstring * func_vis * func_type_params * identifier * func_signature * block
                        | TypeClassDef of unit
                        | ClassInstanceDef of unit

         and type_vis = OpaqueType
                      | PublicType

         and type_params = TyParams of type_param list * universe

         and type_param = TyParam of { name: identifier, universe: universe }

         and universe = LinearUniverse
                      | UnrestrictedUniverse
                      | AnyUniverse
                      | ImplementsClass of identifier

         and slot = Slot of identifier * type_spec * docstring

         and union_case = Case of identifier * type_spec option * docstring

         and type_spec = NamedType of identifier
                       | TupleType of type_spec list
                       | TypeCons of identifier * type_spec list


         and docstring = Docstring of string option
end
