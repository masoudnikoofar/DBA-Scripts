--android

select count (distinct "MobileNumber" ) from MPC."ChannelManagerTransaction" where "RequestDate" between '1397/08/19' and '1397/09/19' and  "Requestversion" like'7.2%' ;

--java

select distinct "MobileNumber" , "Requestversion" , "ProtocolType" from MPC."ChannelManagerTransaction" where "RequestDate" between '1397/08/19' and '1397/09/19' and  "Requestversion" like'7.5%';

--ios

select distinct "MobileNumber" , "Requestversion", "ProtocolType" from MPC."ChannelManagerTransaction" where "RequestDate" between '1397/08/19' and '1397/09/19' and  "Requestversion" like'7.2%';

--gprs

select distinct "MobileNumber" , "Requestversion" , "ProtocolType" from MPC."ChannelManagerTransaction" where "RequestDate" between '1397/08/19' and '1397/09/19' and  "ProtocolType" = '1' ;

--sms

select distinct "MobileNumber" , "Requestversion" , "ProtocolType" from MPC."ChannelManagerTransaction" where "RequestDate" between '1397/08/19' and '1397/09/19' and  "ProtocolType" = '2' ;

--COUNT

select  distinct "MobileNumber", "Requestversion"  from MPC."ChannelManagerTransaction" where "RequestDate" between '1397/08/19' and '1397/09/19';

select count ( distinct "MobileNumber")  from MPC."ChannelManagerTransaction" where "RequestDate" between '1397/08/19' and '1397/09/19' and  "ProtocolType" = '1' ;
