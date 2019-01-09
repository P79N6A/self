import time

def getTimestamp( strTo ):
    return int( time.mktime(time.strptime( strTo, '%Y-%m-%d' )) )

def getTodayDate():
    return time.strftime("%Y-%m-%d")

def getLastdayDate():
    return time.strftime("%Y-%m-%d", time.localtime(int( time.mktime(time.strptime( time.strftime("%Y-%m-%d"), '%Y-%m-%d' )) )-86400) )

def getTodayTimestamp():
    return int( time.mktime(time.strptime( time.strftime("%Y-%m-%d"), '%Y-%m-%d' )) )

def getLastdayTimestamp():
    return int( time.mktime(time.strptime( time.strftime("%Y-%m-%d"), '%Y-%m-%d' )) )-86400

print( getTimestamp('2011-09-29') - getTimestamp('2011-09-28') )
print( getTimestamp('2011-09-29') )
print( getTodayDate(), getLastdayDate() )
print( getTodayTimestamp(), getLastdayTimestamp() )
