#import "mainController.h"

@implementation mainController ( GLES )

- (void)setGLESContext
{
    
    CAEAGLLayer* eaglLayer = (CAEAGLLayer*)GLES_View.layer;
    
    eaglLayer.opaque = TRUE;
    eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking,
                                    kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat,
                                    nil];
    
    // Making Context
    eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    BOOL status = [EAGLContext setCurrentContext:eaglContext];
    NSLog(@"eaglContext current %d", status);
    
    
    // Set OpenGL Status
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    glEnable( GL_DEPTH_TEST );
    
		// glEnable( GL_POINT_SMOOTH );
		// glEnable( GL_LINE_SMOOTH );
    
    
    glLineWidth(1.0f);
    //glPointSize( 3.0f );
    
    glEnableVertexAttribArray(0);
    glEnableVertexAttribArray(1);
    glEnableVertexAttribArray(2);
    glEnableVertexAttribArray(3);
    glEnableVertexAttribArray(4);
    glEnableVertexAttribArray(5);
    glEnableVertexAttribArray(6);
    glEnableVertexAttribArray(7);
}


- (void)readBoardShaderSource
{
    int status;
    
    NSArray* sourceArray = [ShaderSource_View.text componentsSeparatedByString:@"%"];
    
    NSString* vs_string = [sourceArray objectAtIndex:0];
    NSString* fs_string = [sourceArray objectAtIndex:1];
    NSString* ges_vs_string = [sourceArray objectAtIndex:2];
    NSString* ges_fs_string = [sourceArray objectAtIndex:3];
    NSString* ges_2_vs_string = [sourceArray objectAtIndex:4];
    NSString* ges_2_fs_string = [sourceArray objectAtIndex:5];
    
    const GLchar* vs_source = (GLchar*)[vs_string UTF8String];
    const GLchar* fs_source = (GLchar*)[fs_string UTF8String];
    const GLchar* ges_vs_source = (GLchar*)[ges_vs_string UTF8String];
    const GLchar* ges_fs_source = (GLchar*)[ges_fs_string UTF8String];
    const GLchar* ges_2_vs_source = (GLchar*)[ges_2_vs_string UTF8String];
    const GLchar* ges_2_fs_source = (GLchar*)[ges_2_fs_string UTF8String];
    
    // Create shader object
    BOARD_VS_SOBJ = glCreateShader(GL_VERTEX_SHADER);
    BOARD_FS_SOBJ = glCreateShader(GL_FRAGMENT_SHADER);
    
    // Shader Source
    glShaderSource(BOARD_VS_SOBJ, 1, &vs_source, NULL);
    glShaderSource(BOARD_FS_SOBJ, 1, &fs_source, NULL);
    
    
    // Compile shader
    glCompileShader(BOARD_VS_SOBJ);
    glCompileShader(BOARD_FS_SOBJ);
    
    glGetShaderiv(BOARD_VS_SOBJ, GL_COMPILE_STATUS, &status);
    NSLog(@"BOARD compile VS %d", status);
    glGetShaderiv(BOARD_FS_SOBJ, GL_COMPILE_STATUS, &status);
    NSLog(@"BOARD compile FS %d", status);
    
    // Create Program
    BOARD_POBJ = glCreateProgram();
    
    // Attach shader
    glAttachShader(BOARD_POBJ, BOARD_VS_SOBJ);
    glAttachShader(BOARD_POBJ, BOARD_FS_SOBJ);
    
    // Bind Attrib location
    glBindAttribLocation( BOARD_POBJ, 0, "position");
    glBindAttribLocation( BOARD_POBJ, 1, "texCoord");
    
    // Link
    glLinkProgram( BOARD_POBJ );
  
    
    glGetProgramiv(BOARD_POBJ, GL_LINK_STATUS, &status);
    NSLog(@"BOARD link status %d", status );
    
    //Get Uniform Location
    UNF_boardTexture = glGetUniformLocation(BOARD_POBJ, "boardTexture");
    UNF_faderValue = glGetUniformLocation(BOARD_POBJ, "faderValue");
    NSLog(@"UNF_boardTexture %d", UNF_boardTexture);
    NSLog(@"UNF_faderValue %d", UNF_faderValue);
    
    glValidateProgram( BOARD_POBJ );
    glGetProgramiv( BOARD_POBJ, GL_VALIDATE_STATUS, &status );
    NSLog(@"BOARD validate %d", status );
    
    glDeleteShader(BOARD_VS_SOBJ);
    glDeleteShader(BOARD_FS_SOBJ);
    
    
    
// Gesture Shader
    GESTURE_VS_SOBJ = glCreateShader(GL_VERTEX_SHADER);
    GESTURE_FS_SOBJ = glCreateShader(GL_FRAGMENT_SHADER);
    
    // Shader source
    glShaderSource(GESTURE_VS_SOBJ, 1, &ges_vs_source, NULL);
    glShaderSource(GESTURE_FS_SOBJ, 1, &ges_fs_source, NULL);
    
    // Compile shader
    glCompileShader(GESTURE_VS_SOBJ);
    glCompileShader(GESTURE_FS_SOBJ);
    
    glGetShaderiv(GESTURE_VS_SOBJ, GL_COMPILE_STATUS, &status);
    NSLog(@"GESTURE compile VS %d", status);
    glGetShaderiv(GESTURE_FS_SOBJ, GL_COMPILE_STATUS, &status);
    NSLog(@"GESTURE compile FS %d", status);
    
    // Create Program
    GESTURE_POBJ = glCreateProgram();
    
    // Attach shader
    glAttachShader(GESTURE_POBJ, GESTURE_VS_SOBJ);
    glAttachShader(GESTURE_POBJ, GESTURE_FS_SOBJ);
    
    // Bind Attrib Location
    glBindAttribLocation( GESTURE_POBJ, 0, "position");
    
    // Link
    glLinkProgram( GESTURE_POBJ );

    
    glGetProgramiv( GESTURE_POBJ, GL_LINK_STATUS, &status );
    NSLog(@"GESTURE Link status %d", status );
    
    // Get uniform location
    UNF_color = glGetUniformLocation(GESTURE_POBJ, "color");
    NSLog(@"UNF_color %d", UNF_color);
    
    // validate program
    glValidateProgram( GESTURE_POBJ );
    glGetProgramiv( GESTURE_POBJ, GL_VALIDATE_STATUS, &status );
    NSLog(@"GESTURE validate %d", status );
    
    glDeleteShader(GESTURE_VS_SOBJ);
    glDeleteShader(GESTURE_FS_SOBJ);

    
    
    
    // Gesture Shader
    GESTURE_2_VS_SOBJ = glCreateShader(GL_VERTEX_SHADER);
    GESTURE_2_FS_SOBJ = glCreateShader(GL_FRAGMENT_SHADER);
    
    // Shader source
    glShaderSource(GESTURE_2_VS_SOBJ, 1, &ges_2_vs_source, NULL);
    glShaderSource(GESTURE_2_FS_SOBJ, 1, &ges_2_fs_source, NULL);
    
    // Compile shader
    glCompileShader(GESTURE_2_VS_SOBJ);
    glCompileShader(GESTURE_2_FS_SOBJ);
    
    glGetShaderiv(GESTURE_2_VS_SOBJ, GL_COMPILE_STATUS, &status);
    NSLog(@"GESTURE 2 compile VS %d", status);
    glGetShaderiv(GESTURE_2_FS_SOBJ, GL_COMPILE_STATUS, &status);
    NSLog(@"GESTURE 2 compile FS %d", status);
    
    // Create Program
    GESTURE_2_POBJ = glCreateProgram();
    
    // Attach shader
    glAttachShader(GESTURE_2_POBJ, GESTURE_2_VS_SOBJ);
    glAttachShader(GESTURE_2_POBJ, GESTURE_2_FS_SOBJ);
    
    // Bind Attrib Location
    glBindAttribLocation( GESTURE_2_POBJ, 0, "position");
    glBindAttribLocation( GESTURE_2_POBJ, 1, "color");
    
    // Link
    glLinkProgram( GESTURE_2_POBJ );
    
    glGetProgramiv( GESTURE_2_POBJ, GL_LINK_STATUS, &status );
    NSLog(@"GESTURE 2 Link status %d", status );
    
    // Get uniform location
    
    // validate program
    glValidateProgram( GESTURE_2_POBJ );
    glGetProgramiv( GESTURE_2_POBJ, GL_VALIDATE_STATUS, &status );
    NSLog(@"GESTURE 2 validate %d", status );
    
    glDeleteShader(GESTURE_2_VS_SOBJ);
    glDeleteShader(GESTURE_2_FS_SOBJ);

    glUseProgram(0);
}







- (void)setBuffers
{
    NSLog(@"setBuffers");
    int status;
    
    
// set common bg texture
    NSInteger ImgWidth;
    NSInteger ImgHeight;
    CGContextRef textureContext;
    GLubyte* texPointer;
    
    CGImageRef bgTexture = [UIImage imageNamed:@"BG_Texture.png"].CGImage;
    
    ImgWidth = CGImageGetWidth( bgTexture );
    ImgHeight = CGImageGetHeight( bgTexture );
    
    texPointer = (GLubyte*)malloc(ImgWidth*ImgHeight*4);
    
    textureContext = CGBitmapContextCreate(
                                           texPointer, 
                                           ImgWidth, 
                                           ImgHeight,
                                           8,
                                           ImgWidth*4,
                                           CGImageGetColorSpace(bgTexture),
                                           kCGImageAlphaPremultipliedLast
                                           );
    
    CGContextDrawImage( textureContext, CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), bgTexture);
    CGContextRelease( textureContext );
    
    
    glGenTextures(1, &Tex_BGTexture);
    
    glActiveTexture(GL_TEXTURE5);
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, Tex_BGTexture);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    glTexImage2D(
                 GL_TEXTURE_2D, 
                 0, 
                 GL_RGBA, 
                 ImgWidth, 
                 ImgHeight, 
                 0, 
                 GL_RGBA, 
                 GL_UNSIGNED_BYTE, 
                 texPointer
                 );
    
    free(texPointer);
    
    
    
//    CGImageRef bgTexture = [UIImage imageNamed:@"BG_Texture.bmp"].CGImage;
//    
//    ImgWidth = CGImageGetWidth( bgTexture );
//    ImgHeight = CGImageGetHeight( bgTexture );
//    
//    texPointer = (GLubyte*)malloc(ImgWidth*ImgWidth*4);
//    
//    textureContext = CGBitmapContextCreate(
//                                           texPointer, 
//                                           ImgWidth, 
//                                           ImgHeight,
//                                           8,
//                                           ImgWidth*4,
//                                           CGImageGetColorSpace(bgTexture),
//                                           kCGImageAlphaPremultipliedLast
//                                           );
//    
//    CGContextDrawImage( textureContext, CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), bgTexture);
//    CGContextRelease( textureContext );
//    
//    
//    glGenTextures(1, &Tex_BGTexture);
//    
//    glActiveTexture(GL_TEXTURE5);
//    glEnable(GL_TEXTURE_2D);
//    glBindTexture(GL_TEXTURE_2D, Tex_BGTexture);
//    
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
//    
//    glTexImage2D(
//                 GL_TEXTURE_2D, 
//                 0, 
//                 GL_RGBA, 
//                 ImgWidth, 
//                 ImgHeight, 
//                 0, 
//                 GL_RGBA, 
//                 GL_UNSIGNED_BYTE, 
//                 texPointer
//                 );
//    
//    free(texPointer);
   
    
    
    glGenFramebuffers(1, &FBO_Rendering);
    glGenFramebuffers(1, &FBO_Moniter);
    
    glGenTextures(1, &TEX_Rendering);
    glGenTextures(1, &TEX_Depth);
    
    glGenRenderbuffers(1, &RBO_Monitor);
    
// Set Rendering Texture buffer
    glBindFramebuffer(GL_FRAMEBUFFER, FBO_Rendering);
    
    glActiveTexture(GL_TEXTURE6);
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, TEX_Rendering);
    
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );
    
    
    short RESOLUTION;
    
    if(iPad_model_No == 1)
    {
        RESOLUTION = 512;
    }
    else
    {
        RESOLUTION = 1024;
    }
    
    glTexImage2D(
                 GL_TEXTURE_2D, 
                 0, 
                 GL_RGBA, 
                 RESOLUTION, 
                 RESOLUTION, 
                 0, 
                 GL_RGBA, 
                 GL_UNSIGNED_BYTE, 
                 0
                 );
    glFramebufferTexture2D(
                           GL_FRAMEBUFFER, 
                           GL_COLOR_ATTACHMENT0, 
                           GL_TEXTURE_2D, 
                           TEX_Rendering, 
                           0
                           );
    
    glActiveTexture(GL_TEXTURE7);
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, TEX_Depth);
    
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );
    
    glTexImage2D(
                 GL_TEXTURE_2D, 
                 0, 
                 GL_DEPTH_COMPONENT, 
                 RESOLUTION, 
                 RESOLUTION, 
                 0, 
                 GL_DEPTH_COMPONENT, 
                 GL_UNSIGNED_SHORT, 
                 0
                 );
    glFramebufferTexture2D(
                           GL_FRAMEBUFFER, 
                           GL_DEPTH_ATTACHMENT, 
                           GL_TEXTURE_2D, 
                           TEX_Depth, 
                           0
                           );
    
    status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    NSLog(@"FBO_Rendering : %x(8cd5)", status);

    
    
// Set monitor FBO
    glBindFramebuffer(GL_FRAMEBUFFER, FBO_Moniter);
    glBindRenderbuffer(GL_RENDERBUFFER, RBO_Monitor);
   // glRenderbufferStorage(GL_RENDERBUFFER, GL_RGBA, 640, 480);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, RBO_Monitor);
    [eaglContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer*)GLES_View.layer];

    status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    NSLog(@"FBO_Monitor : %x(8cd5)", status);
    
    
}


@end