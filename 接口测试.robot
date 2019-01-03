*** Settings ***
Library           requests
Library           RequestsLibrary
Library           Collections
Library           json

*** Test Cases ***
loginSys_post
    ${header}    Create Dictionary    content-type    application/x-www-form-urlencoded
    ${dict}    Create Dictionary    areaCode=86    account=13480251015    passwd=jy452aXMu/ULyEZzKVWspIXK5DdGP32yJvhcxiezPmV/mNnU14ZH+6tmPS/aXmq9F2nxNTHxRYh5tYN5B9wLSL8YdQNGjgaztDNEeIKvFhQ+ksenzrKRFO3F7kOsJRZMCchkTVEp4y3LJv26d0psbO4mmOp4icN1Nb7dcO/OCDVY3TFlCp5nYQ4guPVxEPV4JdA9V9+P/sFrUvfyCgV1Y6DaWpm76sq2Kl76zRrayf/J1hU/wn9MC+IG1Ku74CJewLHUL6+Uk/erLyCibDHKNpsS/F5IcQfO3nRw+83qkikFNJlIzmPbuKU5dDwIDc9rvn1bncr6s9I5Ulahev+m/Q==
    create session    api    http://115.29.142.212:8020    ${header}
    ${addr}    post request    api    /mobile/user/login    data=${dict}
    log    ---开始断言验证---
    Should Be Equal As Strings    ${addr.status_code}    200
    ${responseData}    json.loads    ${addr.content}
    #    ${token}    get from dictionary    ${responseData}    data
    #token
    ${token}    Set Variable    ${responseData['data']['token']}
    Set Global Variable    ${token}
    #用户id
    ${user_id}    Set Variable    ${responseData['data']['id']}
    Set Global Variable    ${user_id}

getCommunity_post
    ${header}    Create Dictionary    content-type    application/x-www-form-urlencoded
    ${dict}    Create Dictionary    id=${user_id}    token=${token}
    create session    api    http://115.29.142.212:8020    ${header}
    ${addr}    post request    api    /Mobile/Community/getCommunitiesWithAuthority    data=${dict}
    log    ${addr.content}
    ${responseData}    json.loads    ${addr.content}
    Should Be Equal As Strings    ${addr.status_code}    200

getBFCInfo_post
    ${header}    Create Dictionary    content-type    application/x-www-form-urlencoded
    ${dict}    Create Dictionary    id=${user_id}    token=${token}    communityId=641
    create session    api    http://115.29.142.212:8020    ${header}
    ${addr}    post request    api    /Mobile/Room/getBFR    data=${dict}
    ${responseData}    json.loads    ${addr.content}
    Should Be Equal As Strings    ${addr.status_code}    200

addBuilding_post
    ${header}    Create Dictionary    content-type    application/x-www-form-urlencoded
    ${dict}    Create Dictionary    id=${user_id}    token=${token}
    create session    api    http://115.29.142.212:8020    ${header}
    ${addr}    post request    api    /Mobile/Community/getCommunitiesWithAuthority    data=${dict}
    log    ${addr.content}
    ${responseData}    json.loads    ${addr.content}
    Should Be Equal As Strings    ${addr.status_code}    200

json_convert_dict
    ${msg}    set variable    {'a':'1','b':'2'}
    log    ${msg}
    #json字符串转换为dictionary
    ${msgDic}    Evaluate    demjson.decode(u'${msg}')    demjson
    log    $(msgDic}
