call main()
sub main()
    Dim xmlHTTP, url
    Set xmlHTTP = WScript.CreateObject("Msxml2.XMLHTTP")
    url = "http://dbmonitoring.enb.local/test/db_backup_check.php?db_name=filer_full"
    xmlHTTP.Open "GET", url, False
    xmlHTTP.Send  ""
end sub 