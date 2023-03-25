(* #require "dns-client.unix" ;;
   #require "rresult";;
*)
let getmxbydomain domain =
  let dns = Dns_client_unix.create () in
  Dns_client_unix.getaddrinfo dns Dns.Rr_map.Mx domain

let () =
  let domain = Domain_name.of_string_exn Sys.argv.(1) in
  let _ttl, response = Rresult.R.failwith_error_msg (getmxbydomain domain) in
  (*Fmt.pr "@[<hov>%a@]\n%!" Fmt.(Dump.list Dns.Mx.pp) (Dns.Rr_map.Mx_set.elements response)*)
  let lst = Dns.Rr_map.Mx_set.elements response in
  let rec show = function 
    | [] -> Fmt.pr "\n"
    | x :: xs -> (Fmt.pr "@[<hov>%a@], " Dns.Mx.pp x; show xs)
  in (
    Fmt.pr "\n";
    show lst;
    Fmt.pr "\n";)

