'''
Created on Nov 6, 2018

@author: kumarsis
'''
# -*- coding: cp1252 -*-
# The execution starts from calling  validate_Input(inputFilePath) in which ith path of input directory is given
# this function checks if a file called common.bin is present or not.if it is present it checks if credentials are present
# in encrypted format in it or not.if  found it reads th common.bin line by line, decrypts the credentials and stores in
# a temporary file name temp.txt. Now from this file values are read one by one and checked if the UUID(computers unique identification number)
# of the computer running the code matches with any already stored UUID in the common.bin(and temp.txt after encryption).if it matches  it means,
# this computer has run the script earlier and was authorised.Now when the UUID matches, the function again reads the next line(userid in temp.txt)
# to see if the userid stored in common.bin in encrypted format (now also  in temp.txt after decryption) matches the current user id of the user.
# if both of these match, then the authentication passes and ATT_Username and password are printed.

# if the file common.bin is not present ,check_input_file(inputfilepath) is called which also takes the path of input directory as parameter.It checks
# if input.txt is present or not.if it is not present it gives error that inputfile is not present.if it is present it checks if the file is empty
# or not, if it is empty an error is displayed that the file is empty.Else all the credentials are read from input .txt and stored in variables.
# also it is checked that common.bin file is present or not in the input directory.if not, it is created
# then UpdateNewuser(UUID,inputFilePath) function is called .This functions takes the variables from input.txt and also UUID(in parameter),it encrypts
# them and stores in the file called common.bin in the input directory.then again validate_Input(inputFilePath) is called and process begins from beginning.

# Thus it is a two level authentication (UUID and userId) as well as encryption to make the authentication as secure as possible.The algorithm
# uses AES encryption for 128 bit encryption.Still the key can be more of any bit lenght(not just multiple of 16 ) as it uis hashed.

from  Crypto.Cipher import AES
import base64
from Crypto import Random
import os
from io import BytesIO
# import platform, os
import subprocess
import getpass
from Crypto.Hash import SHA256
from encodings import utf_8

'''def encryption(privateInfo):
    Block_Size = 16
    PADDING = "{"
    pad = lambda s:s + (Block_Size - len(s) % Block_Size) * PADDING
    EncodeAES = lambda c, s: base64.b64encode(c.encrypt(pad(s)))
    secret = os.urandom(Block_Size)
    print 'string without encryption is :',privateInfo
    print 'encryption key:',secret
    cypher = AES.new(secret)
    encoded = EncodeAES(cypher,privateInfo)
    print 'encrypted message is :',encoded

encryption("this is my string to be encrypted")

def decryption(encryptedString):
    #Block_Size = 16
    PADDING = "{"
   # pad = lambda s: s + (Block_Size - len(s) % Block_Size) * PADDING
    DecodeAES = lambda c, e: c.decrypt(base64.b16decode(e)).rstrip(PADDING)
    key = "?yN?}??(???s?%"
    cypher = AES.new(key)
    decoded = DecodeAES(cypher,encryptedString)
    print "decoded code is ",decoded

decryption("ci5vp9QUQlBQGqyjRDVKBOIEx62EPdNLEKY+rPEq1N4UcrbwcfXjfy6nxKji+N+a")
'''
# BS = 16
# pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
# unpad = lambda s : s[0:-ord(s[-1])]

BS = 16
pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
#unpad = lambda s: s[0:-ord(s[-1])]
unpad = lambda s: s[0:-s[-1]]
credentials = None


# class AESCipher:
class AuthenticationNew:
    
    def __init__(self, key):
        self.key = SHA256.new(key).digest()

# #function to encrypt raw data
    def encrypt(self, raw):
        raw = pad(raw).encode('utf-8')
        iv = Random.new().read(AES.block_size)
        
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        #return base64.b64encode(iv + cipher.encrypt(raw.encode('ascii', 'ignore')))
        print("testing encode")
        return base64.b64encode(iv + cipher.encrypt(raw))

# #function to decrypt raw data
    def decrypt(self, enc):
        enc = base64.b64decode(enc)
       # iv = Random.new().read(AES.block_size)
        iv = enc[:16]
       
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        print("before open file2")
        return unpad(cipher.decrypt(enc[16:]))
#######################################################################################################################
#######################################################################################################################

# #function to get UUID
    def cpu_info(self):
        #important changed the below line as bytes and string are copnsidered different in python3 and not in python2
       # current_machine_id = base64.b64encode(subprocess.check_output('wmic csproduct get uuid').split('\n')[1].strip())
        current_machine_id = subprocess.check_output('wmic csproduct get uuid').decode('utf-8').strip('UUID').replace('\n','').strip()
        print("machine id is " ,current_machine_id)
        return current_machine_id

    #####################################################################################################################
    #####################################################################################################################
    UUID_Actual = cpu_info(None)

    # cipher = Authentication(None)
    secret = cpu_info(None) 
             
#     encrypted = encrypt('bawa@06093bawa@06093')
#     decrypted = decrypt(encrypted)    
    # secret = os.urandom(BS)
  
    #######################################################################################################################
    #######################################################################################################################

    def getUsername(self):
        user_name = getpass.getuser()
        return user_name
    
    #######################################################################################################################
    #######################################################################################################################
    def file_read(self, fname):
        with open(fname) as f:
            # Content_list is the list that contains the read lines.
            # line = f.readline()
            content_list = f.readlines()
            # print(content_list)
            return content_list
    
    # name=file_read(None,"C:\\SourceCloud\\smoketest\\properties\\Input\\input.txt")
    # print name[0]
    
    #######################################################################################################################
    #######################################################################################################################
    
    # #function to create a new file in the given file path
    def createFile(self, filePath):
        f = open(filePath, 'w+')
        f.close()
    
    #######################################################################################################################
    #######################################################################################################################
    
    # #reading inputs from input.txt and setting variables for the run
    # it checks if file is present or not.if yes is it vacant or not.if not
    # het values of credentials from this file and call UpdateNewuser(UUID, inputFilePath) to set encrted values of variables in common.bin
                
    def check_input_file(self, inputFilePath):
        print("calling check input")
        commonFilePath = inputFilePath
        if os.path.isfile(inputFilePath + "\\input.txt"):
           name = self.file_read(inputFilePath + "\\input.txt")
           if not len(name) == 0:
               print("using input file")
               global user_name
               user_name = name[0]
               global att_user
               att_user = name[1]
               global password
               password = name[2]
               global itServicesPassword
               itServicesPassword = name[3]
               print(user_name)
               print(att_user)
               print(password)
               print(itServicesPassword)
               self.UpdateNewuser(UUID, inputFilePath)
               open(inputFilePath + '\\input.txt', 'w').close()
           else:
               print("input file is blank or not present and credentials could not be matched")
               exit(1)
    
        else:
            print("file does not exist")
        print ("after if condition")
        return self.credentials
        if not os.path.isfile(inputFilePath + "\\common.bin"):
            print ("testing")
            self.createFile(inputFilePath + "\\common.bin")
    #######################################################################################################################
    #######################################################################################################################
    # check_input_file("C:\\SourceCloud\\smoketest\\properties\\Input")
    
    #######################################################################################################################
    #######################################################################################################################
    
    # #encrypting username and passwords and other variables and writing in common.bin
    def UpdateNewuser(self, UUID, commonFilePath):
        print("calling update")
        with open(commonFilePath + '\\common.bin', 'a+') as f:
    
            f.writelines(self.encrypt(UUID).decode('utf-8'))
            f.write("\n")
           # print self.encrypt(UUID)
            print(user_name)
            f.writelines(self.encrypt(user_name).decode('utf-8'))
            f.write("\n")
           # print self.encrypt(user_name)
            f.writelines(self.encrypt(att_user).decode('utf-8'))
            f.write("\n")
           # print self.encrypt(att_user)
            f.writelines(self.encrypt(password).decode('utf-8'))
            f.write("\n")
           # print self.encrypt(password)
            if itServicesPassword == None:
               f.writelines(self.encrypt("dummy_value").decode('utf-8'))
               f.write("\n")
            else:
               f.writelines(self.encrypt(itServicesPassword).decode('utf-8'))
               f.write("\n")
            f.writelines("--------------------------------------------------------------------------------------------------------")
            f.write("\n")
       # print ('UserID is ' + att_user)
        #print ('password is ' + password)
        open(commonFilePath + '\\input.txt', 'w').close()
        self.validate_Input(commonFilePath)
    
    #######################################################################################################################
    #######################################################################################################################
    
    # #validating values of username and passwords.it checks if UUID, username , att_username, password matches with that present in common.bin
    # if it matches it returns a list of credentials containing att_usernams,password and itservicesPassword
    def validate_Input(self, commonFilePath):
        print ("calling validate")
        self.createFile(commonFilePath + "\\temp.txt")
        if os.path.isfile(commonFilePath + "\\common.bin"):
            with open(commonFilePath + '\\common.bin', 'r+') as file:
                    global UUID
                    print("before file")
                    UUID = self.decrypt(file.readline()).decode('utf-8')
                    print(UUID)
                   # print("after open file")
                    global user_name
                    user_name = self.decrypt(file.readline()).decode('utf-8')
                    global att_user
                   # print(user_name)
                    att_user = self.decrypt(file.readline()).decode('utf-8')
                    global password
                    password = self.decrypt(file.readline()).decode('utf-8')
                    #print(password)
                    #print "password is " + password
                    global itServicesPassword
                    itServicesPassword = self.decrypt(file.readline()).decode('utf-8')
                    #print(itServicesPassword)
                
                    global lineSeparator
                
                    lineSeparator = file.readline()
                    print("before open file")
                   # print "line separator is  " + lineSeparator
                    with open(commonFilePath + '\\temp.txt', 'a+') as fileTemp:
                            fileTemp.write(UUID)
                            fileTemp.write("\n")
                            fileTemp.write(user_name)
                            # fileTemp.write("\n")
                            fileTemp.write(att_user)
                            # fileTemp.write("\n")
                            fileTemp.write(password)
                            
                            # fileTemp.write("\n")
                            fileTemp.write(itServicesPassword)
                            fileTemp.write("\n")
                            fileTemp.write(lineSeparator)
                            print ("line is " + lineSeparator)
                            # fileTemp.write("\n")
            with open(commonFilePath + '\\temp.txt', 'r') as TempFile:
    
                user_name_Actual = self.getUsername()
               # print "user_name_Actual is " + user_name_Actual
    
                UUID_final = TempFile.readline()
               # print UUID_final
                user_name_final = TempFile.readline()
               # print user_name_final
                att_user_final = TempFile.readline()
               # print att_user_final
                Password_final = TempFile.readline()
               # print Password_final
                itServicesPassword_final = TempFile.readline()
                #print itServicesPassword_final
                lineSeparator_final = TempFile.readline()

                if '"UUID_final"=="UUID_Actual"':
                    print ("UUID is matched and correct")
                    if '"user_name_final"=="user_name_Actual"':
                        print ("UUID and username matches let's check credentials now")
                        if '"att_user_final"=="att_user"':
                             print ("att_user matches.now let's check password")
                             if '"Password_final"="password"':
                                 print(" trying password also matches.Congratulations, user is authentic")
                                 # global credentials
                                 self.credentials = [att_user, password, itServicesPassword]

    
                else:
                    # exit(1)
                    self.check_input_file(commonFilePath)
            TempFile.close()
            
            open(commonFilePath + '\\temp.txt', 'w+').close()

            return self.credentials
        else:
            self.check_input_file(commonFilePath)
    
    #######################################################################################################################
    #######################################################################################################################
    
    def main(self, inputFilePath):
        global UUID
        UUID = self.cpu_info()

        self.validate_Input(inputFilePath)
        return self.credentials
    def create_profile(self,path):
        from selenium import webdriver
        fp =webdriver.FirefoxProfile()
        fp.set_preference("browser.download.folderList",2)
        fp.set_preference("browser.download.manager.showWhenStarting",False)
        fp.set_preference("browser.download.dir",path)
        fp.set_preference("browser.helperApps.neverAsk.saveToDisk",'application/csv')
        fp.update_preferences()
        return fp.path

