//
//  GWUser.h
//  GameworksSDK
//
//  Created by tinkl on 7/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWApp.h"

/*!
 *   A GameWroks Framework User Object that is a local representation of a user persisted to the GW Cloud.
 */
@interface GWUser : NSObject


/**  Accessing the Current User */

/*!
 Gets the currently logged in user from disk and returns an instance of it.
 @return a GWUser that is the currently logged in user. If there is none, returns nil.
 */
+ (instancetype)currentUser;

/*!
 Create new GWUser with network
 @return a GWUser that is the currently logged in user. If there is none, returns nil.
 */
+ (instancetype)newUser;

/*!
 *  The userId for the GWUser.
 */
@property (nonatomic, strong) NSString *userId;

/*!
 *  The session token for the GWUser. This is set by the server gamework successful authentication.
 */
@property (nonatomic, strong) NSString *sessionToken;

/*!
 *  The username for the GWUser.
 */
@property (nonatomic, strong) NSString *username;

/*!
 *  The email for the GWUser.
 */
@property (nonatomic, strong) NSString *email;


/*!
 *  The password for the GWUser. This will  be filled in from the server with
 *  the password.
 */
@property (nonatomic, strong) NSString *password;

/*!
 *  The nickname for the GWUser.
 */
@property (nonatomic, strong) NSString *nickname;

/*!
 *  The loginWithType for the GWUser.
 */
@property (nonatomic, strong) NSString *loginWithType;

/*!
 *  The select status from server.
 */
@property (nonatomic,assign) BOOL selected;

/*!
 *  The isTempUser status is make current user json infomation'status.
 */
@property (nonatomic,assign) BOOL isTempUser;


#pragma mark Game'info
///---------------------------------------------------------------------------------------
/// @name  current user login with game, filled games info in from the server .
///---------------------------------------------------------------------------------------

/*!
 *  The  Name of Game.
 */
@property (nonatomic,strong) NSString *currentgamename;

/*!
 *  The url of Game.
 */
@property (nonatomic,strong) NSString *currentgameurl;


/*!
 Whether the user is an authenticated object for the device. An authenticated GWUser is one that is obtained via
 a signUp or logIn method. An authenticated object is required in order to save (with altered values) or delete it.
 @return whether the user is authenticated.
 */
+(BOOL)isAuthenticated;


///---------------------------------------------------------------------------------------
/// @name  Sign Up
///---------------------------------------------------------------------------------------
/*!
 Signs up the user asynchronously. Make sure that password and username are set. This will also enforce that the username isn't already taken.
 @param block The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)signUpInBackgroundWithBlock:(NSString *)username
                           password:(NSString *)password
                              block:(GWBooleanResultBlock)block;

///---------------------------------------------------------------------------------------
/// @name  Logging in
///---------------------------------------------------------------------------------------

/*!
 Makes an asynchronous request to log in a user with specified credentials.
 Returns an instance of the successfully logged in GWUser. This will also cache
 the user locally so that calls to userFromCurrentUser will use the latest logged in user.
 @param username The username of the user.
 @param password The password of the user.
 @param block The block to execute. The block should have the following argument signature: (GWUser *user, NSError *error)
 */
+ (void)logInWithUsernameInBackground:(NSString *)username
                             password:(NSString *)password
                                block:(GWUserResultBlock)block;


/*!
 ReLogin with Username and mark.
 @param username The username of the user.
 @param password The password of the user.
 @param block The block to execute. The block should have the following argument signature: (GWUser *user, NSError *error)
 */
+ (void)relogInWithUsernameInBackground:(NSString *)username
                                block:(GWUserResultBlock)block;


/*!
 Makes an asynchronous request to log in a user with specified credentials.
 Returns an instance of the successfully logged in GWUser. This will also cache
 the user locally so that calls to userFromCurrentUser will use the latest logged in user.
 @param username The username of the user.
 @param password The password of the user.
 @param block The block to execute. The block should have the following argument signature: (GWUser *user, NSError *error)
 */
+ (void)logInWithTempUsernameInBackgroundblock:(GWUserResultBlock)block;


///---------------------------------------------------------------------------------------
/// @name  Logging Out
///---------------------------------------------------------------------------------------

/*!
 Logs out the currently logged in user on disk.
 */
+ (void)logOutInBackgroundblock:(GWBooleanResultBlock)block;

///---------------------------------------------------------------------------------------
/// @name  Cache
///---------------------------------------------------------------------------------------

/*!
 Save User object in user on disk.
 */
+ (void) saveCache:(GWUser *) gwuser;


/*!
 *  Request userinfo by network.
 */
+ (void)requestUserInfoByUID:(NSString *)userid
                            block:(GWStringResultBlock)block;

/*!
 *  Binding temp'user -> normal user.
 */
+ (void)bindWithUsernameInBackground:(NSString *)username
                            password:(NSString *)password
                               block:(GWBooleanResultBlock)block;


/*!
 Send a password reset request asynchronously for a specified email.
 If a user account exists with that email, an email will be sent to that address with instructions
 on how to reset their password.
 @param pass  current password.
 @param newpass new password.
 @param block The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)requestPasswordResetForPasswordInBackground:(NSString *)pass
                                             newpwd:(NSString*)newpass
                                           block:(GWBooleanResultBlock)block;

@end
