+# python 2.7
 +import requests
 +s = requests.session()
 +auth = {
 +	'email':'youremail',
 +	'passwd':'yourpassword'
 +}
 +login = s.post( 'http://test.url/auth/login', data=auth )
 +#user-center can't assign to operator
 +ucenter = s.get('http://test.url/user')
 +if u'不能签到' in ucenter.text:
 +	print (u'已签到')
 
