(*
    Copyright 2018 Fernando Borretti <fernando@borretti.me>

    This file is part of Boreal.

    Boreal is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Boreal is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Boreal.  If not, see <http://www.gnu.org/licenses/>.
*)

signature MIR = sig
    type name = Symbol.symbol

    (* Type System *)

    datatype ty = Bool
                | Integer of Type.signedness * Type.width
                | Float of Type.float_type
                | Tuple of ty list
                | Pointer of ty
                | Disjunction of name * int

    (* AST *)

    type register = int

    datatype operand = BoolConstant of bool
                     | IntConstant of string * ty
                     | FloatConstant of string * ty
                     | NullConstant of ty
                     | RegisterOp of register
                     | VariableOp of Symbol.variable * ty

    datatype operation = ArithOp of Arith.kind * Arith.oper * operand * operand
                       | TupleCreate of operand list
                       | TupleProj of operand * int
                       | Load of operand
                       | SizeOf of ty
                       | Construct of ty * int * operand option
                       | ForeignFuncall of string * operand list * ty

    datatype instruction = Assignment of register * operation * ty
                         | Store of { ptr : operand, value : operand }
                         | DeclareLocal of Symbol.variable * ty * operand
                         | Cond of { test : operand,
                                     consequent : instruction list,
                                     alternate : instruction list,
                                     result : register,
                                     ty : ty }

end
