import os
from BeautifulSoup import BeautifulSoup
import urllib2
import re

localfiles = []
remotefiles = []
diff = []

# ===============================list of Localfiles========================================
def FileLister():
	for file in os.listdir("/var/www/html/OracleLinux/7.3/MySQL57_community/x86_64/getPackage/"):
	    if file.endswith(".rpm"):
	    	global localfiles
	    	localfiles.extend([file])

	# print localfiles

	# for i in range(len(localfiles)):
	# 	print(localfiles[i])
	#Print "Number of Packages in Local Repository: %d" %len(localfiles)	
	print "Number of Packages in Local Repository = %d" %len(localfiles)
# ===============================list of localfiles========================================

# ===============================list of Remote Files======================================
def RemFileLister():

	html_page = urllib2.urlopen("http://public-yum.oracle.com/repo/OracleLinux/OL7/MySQL57_community/x86_64/")
	soup = BeautifulSoup(html_page)		
	for link in soup.findAll('a'):
	    strings = link.get('href')
	    global remotefiles
	    if strings.endswith('.rpm'):
	    	#print strings
		strings = strings.split('/')[-1]		#for Oracle Linux web site Only -- It adds getpackage at the begining of each string
	    	remotefiles.extend([strings])	
	    	

	# print remotefiles			# because of using beautifulsoup, it prints the list with u (unicode)
	# for j in range(len(remotefiles)):
	# 		print(remotefiles[j])

	#Print "Number of New Packages in Remote Repository: %d" %len(remotefiles)		
	print "Number of New Packages in Remote Repository = %d" %len(remotefiles)
# ===============================list of Remote Files========================================


# ===============================Find the required files=====================================
def DiFunc():
	global diff
	diff= list(set(remotefiles) - set(localfiles))
	print "Number of Packages to Download = %d" %len(diff)
# ===============================Find the required files=====================================


# ===============================File Downloader=============================================

def FileDownloader(a):
	for i in range(len(a)):
 		url = "http://yum.oracle.com/repo/OracleLinux/OL7/MySQL57_community/x86_64/getPackage/" + a[i]
 		print url

 		file_name = url.split('/')[-1]
		u = urllib2.urlopen(url)
		fileinpath="/var/www/html/OracleLinux/7.3/MySQL57_community/x86_64/getPackage/"+ file_name
		f = open(fileinpath, 'wb')
		meta = u.info()
		file_size = int(meta.getheaders("Content-Length")[0])
		print "Downloading: %s Bytes: %s" % (file_name, file_size)

		file_size_dl = 0
		block_sz = 8192
		while True:
		    buffer = u.read(block_sz)
		    if not buffer:
		        break

		    file_size_dl += len(buffer)
		    f.write(buffer)
		    status = r"%10d  [%3.2f%%]" % (file_size_dl, file_size_dl * 100. / file_size)
		    status = status + chr(8)*(len(status)+1)
		    print status,

		f.close()

# ===============================File Downloader=============================================

FileLister()
RemFileLister()
DiFunc()
FileDownloader(diff)

