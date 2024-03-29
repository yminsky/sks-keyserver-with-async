(***********************************************************************)
(* Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, *)
(*               2011, 2012, 2013  Yaron Minsky and Contributors       *)
(*                                                                     *)
(* This file is part of SKS.  SKS is free software; you can            *)
(* redistribute it and/or modify it under the terms of the GNU General *)
(* Public License as published by the Free Software Foundation; either *)
(* version 2 of the License, or (at your option) any later version.    *)
(*                                                                     *)
(* This program is distributed in the hope that it will be useful, but *)
(* WITHOUT ANY WARRANTY; without even the implied warranty of          *)
(* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU   *)
(* General Public License for more details.                            *)
(*                                                                     *)
(* You should have received a copy of the GNU General Public License   *)
(* along with this program; if not, write to the Free Software         *)
(* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 *)
(* USA or see <http://www.gnu.org/licenses/>.                          *)
(***********************************************************************)

(** Common services, including error reporting, logging,
  exception handling and port definitions  *)

open Core.Std

exception Transaction_aborted of string
exception Argument_error of string
exception Unit_test_failure of string

(********************************************************************)

(** filters applied to all incoming keys *)
let enforced_filters = ["yminsky.dedup"]

let version_tuple = (-1,-1,-1)          (* CR yminsky: NEED TO FIX THE BUILD to
                                           provide a version number *)
(* for Release versions, COMMONCAMLFLAGS in Makefile should include          *)
(* '-warn-error a'. Development work should use '-warn-error A' for stricter *)
(* language checking. This affects the Ocaml compiler beginning with v4.01.0 *)
let version_suffix = "+" (* + for development branch *)
let compatible_version_tuple = (0,1,5)
let version =
  let (maj_version,min_version,release) = version_tuple in
  sprintf "%d.%d.%d" maj_version min_version release

let compatible_version_string =
        let (maj_version,min_version,release) = compatible_version_tuple in
        sprintf "%d.%d.%d" maj_version min_version release

let period_regexp = Str.regexp "[.]"

let parse_version_string vstr =
  let ar = Array.of_list (Str.bounded_split period_regexp vstr 3) in
  (int_of_string ar.(0), int_of_string ar.(1), int_of_string ar.(2))

(**************************************************************************)
(** Logfile control *)

let logfile = ref stdout
let stored_logfile_name = ref None

(**************************************************************************)

let plerror level format =
  ksprintf (fun s ->
             if !Settings.debug && level  <= !Settings.debuglevel
             then  (
               let tm = Unix.localtime (Unix.time ()) in
               fprintf !logfile "%04d-%02d-%02d %02d:%02d:%02d "
                 (tm.Unix.tm_year + 1900) (tm.Unix.tm_mon + 1)
                 tm.Unix.tm_mday (* date *)
                 tm.Unix.tm_hour tm.Unix.tm_min tm.Unix.tm_sec; (* time *)
               output_string !logfile s;
               output_string !logfile "\n";
               flush !logfile;
             ) )
    format

(**************************************************************************)

let set_logfile extension =
  if !Settings.filelog then
    let fname = (Filename.concat !Settings.basedir extension) ^ ".log" in
    stored_logfile_name := Some fname;
    logfile := open_out_gen [ Open_wronly; Open_creat; Open_append; ]
      0o600 fname;
    plerror 0 "Opening log"

let reopen_logfile () =
  match !stored_logfile_name with
    | None -> ()
    | Some name ->
        Out_channel.close !logfile;
        logfile := open_out_gen [ Open_wronly; Open_creat; Open_append; ]
          0o600 name

(**************************************************************************)

let perror x = plerror 3 x

let eplerror level e format =
  ksprintf (fun s ->
    if !Settings.debug && level  <= !Settings.debuglevel
    then (
      let tm = Unix.localtime (Unix.time ()) in
      fprintf !logfile "%04d-%02d-%02d %02d:%02d:%02d "
        (tm.Unix.tm_year + 1900) (tm.Unix.tm_mon + 1)
        tm.Unix.tm_mday (* date *)
        tm.Unix.tm_hour tm.Unix.tm_min tm.Unix.tm_sec;
      output_string !logfile s;
      fprintf !logfile ": %s\n" (Exn.to_string e);
      flush !logfile;
    ))
    format

let eperror x = eplerror 3 x

(********************************************************************)
(** Setup signals.  In particular, most of the time we want to catch and
  gracefully handle both sigint and sigterm *)

let catch_break = ref true
let set_catch_break bool =
  catch_break := bool

let () =
  let module E = Signal.Expert in
  let handle_interrupt _ =
    if !catch_break
    then raise Sys.Break
  in
  E.handle Signal.term  handle_interrupt;
  E.handle Signal.int   handle_interrupt;
  E.set    Signal.pipe  `Ignore;
  E.set    Signal.usr2  `Ignore;
  E.handle Signal.hup   (fun _ -> reopen_logfile ())


(********************************************************************)

let decomment l =
  match String.index l '#' with
  | None -> l
  | Some pos ->
    String.sub l ~pos:0 ~len:pos

(***************************)

type event = | Add of string
             | Delete of string

type timestamp = float

(************************************************************)
(************************************************************)
(**  Network Related definitions   *)

let whitespace = Str.regexp "[ \t\n]+"
let make_addr_list address_string port =
  let addrlist = Str.split whitespace address_string in
  let servname = if port = 0 then "" else (string_of_int port) in
  let resolver host = List.map ~f:(fun ai -> ai.Unix.ai_addr)
      (Unix.getaddrinfo host servname [Unix.AI_SOCKTYPE Unix.SOCK_STREAM])
  in
  List.concat (List.map ~f:resolver addrlist)

let recon_port = !Settings.recon_port
let recon_address = !Settings.recon_address
let http_port = !Settings.hkp_port
let http_address = !Settings.hkp_address
let db_command_name = Filename.concat !Settings.basedir "db_com_sock"
let recon_command_name = Filename.concat !Settings.basedir "recon_com_sock"

let db_command_addr = Unix.ADDR_UNIX db_command_name
let recon_command_addr = Unix.ADDR_UNIX recon_command_name

let recon_addr_to_http_addr addr = match addr with
    Unix.ADDR_UNIX _ -> failwith "Can't convert UNIX address"
  | Unix.ADDR_INET (inet_addr,port) -> Unix.ADDR_INET (inet_addr,port + 1)


let get_client_recon_addr () =
  make_addr_list recon_address 0
let get_client_recon_addr =
  Utils.unit_memoize get_client_recon_addr

let match_client_recon_addr addr =
  let family = Unix.domain_of_sockaddr addr in
  List.find_exn (get_client_recon_addr ()) ~f:(fun caddr ->
    family = Unix.domain_of_sockaddr caddr)

