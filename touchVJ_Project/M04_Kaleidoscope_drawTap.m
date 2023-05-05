
#import "M04_Kaleidoscope.h"

@implementation M04_Kaleidoscope ( DRAW_TAP )

- (void)drawTap
{
    int n, a, b;
    
    if( iPad_model_No == 2 )
        { glLineWidth(2.0); }
    else if( iPad_model_No == 1 )
        { glLineWidth(1.0); }

    
    GLfloat tapVertex[M04_TAP_NUM][54][3][4];
    GLfloat tapColor[M04_TAP_NUM][54][3][4];
    GLfloat tapTexCoord[M04_TAP_NUM][54][3][2];
    
    GLfloat texCoord_Base[3][2];
    
    float texSize = act_texScale*0.1 + 0.1;
    float texRadian = M_PI_2 + act_texScale;
    
    

    for( n = 0 ; n < M04_TAP_NUM ; n++ )
    {
        
        texCoord_Base[0][0] = 0.5 + tapTexCoordShift[n] + cosf(texRadian)*texSize;
        texCoord_Base[0][1] = 0.5 + tapTexCoordShift[n] + sinf(texRadian)*texSize;
        
        texCoord_Base[1][0] = 0.5 + tapTexCoordShift[n] + cosf(texRadian + 120.0*0.0174532925)*texSize;
        texCoord_Base[1][1] = 0.5 + tapTexCoordShift[n] + sinf(texRadian + 120.0*0.0174532925)*texSize;
        
        texCoord_Base[2][0] = 0.5 + tapTexCoordShift[n] + cosf(texRadian + 240.0*0.0174532925)*texSize;
        texCoord_Base[2][1] = 0.5 + tapTexCoordShift[n] + sinf(texRadian + 240.0*0.0174532925)*texSize;

        //********************************************************************************
        glUseProgram(PRG_FBO_DRAW);
        glUniformMatrix4fv(UNF_mvp_Matrix, 16, GL_FALSE, MATRIX);
        glUniform1i(UNF_FBO_Tex, 0);// texture 0
        //********************************************************************************
        
        if( isTapDraw[n] )
        {
            for( a = 0 ; a < 54 ; a++ )
            {
                float tempColor;
                float tempAlpha;
                
                if( a < 6 )
                {
                    if (TAP_DRAW_COUNTER[n] < 2 )
                    {
                        tempColor = 1.0f;
                        tempAlpha = 1.0f;
                    }
                    else if( TAP_DRAW_COUNTER[n] >= 2 & TAP_DRAW_COUNTER[n] < 42 )
                    {
                        tempColor = 0.0f;
                        tempAlpha = sinf( (42 - TAP_DRAW_COUNTER[n])*0.025*M_PI );
                    }
                    else
                    {
                        tempColor = 0.0f;
                        tempAlpha = 0.0f;
                    }
                }
                else if( a >= 6 && a < 24 )
                {
                    if( TAP_DRAW_COUNTER[n] >= 6 && TAP_DRAW_COUNTER[n] < 8 )
                    {
                        tempColor = 1.0f;
                        tempAlpha = 1.0f;
                    }
                    else if( TAP_DRAW_COUNTER[n] >= 8 && TAP_DRAW_COUNTER[n] < 48 )
                    {
                        tempColor = 0.0f;
                        tempAlpha = sinf( (48 - TAP_DRAW_COUNTER[n])*0.025*M_PI );
                    }
                    else
                    {
                        tempColor = 0.0f;
                        tempAlpha = 0.0f;
                    }
                }
                else
                {
                    if( TAP_DRAW_COUNTER[n] >= 12 && TAP_DRAW_COUNTER[n] < 14 )
                    {
                        tempColor = 1.0f;
                        tempAlpha = 1.0f;
                    }
                    else if( TAP_DRAW_COUNTER[n] > 14 && TAP_DRAW_COUNTER[n] <= 54 )
                    {
                        tempColor = 0.0f;
                        tempAlpha = sinf( (54 - TAP_DRAW_COUNTER[n])*0.025*M_PI );
                    }
                    else
                    {
                        tempColor = 0.0f;
                        tempAlpha = 0.0f;
                    }
                }
                
                for( b = 0 ; b < 3 ; b++ )
                {
                    tapVertex[n][a][b][0] = tapCenter[n][0] + tapVertex_Base[a][b][0];
                    tapVertex[n][a][b][1] = tapCenter[n][1] + tapVertex_Base[a][b][1];
                    tapVertex[n][a][b][2] = tapCenter[n][2];
                    tapVertex[n][a][b][3] = 1.0f;
                    
                    tapColor[n][a][b][0] = tempColor;
                    tapColor[n][a][b][1] = tempColor;
                    tapColor[n][a][b][2] = tempColor;
                    tapColor[n][a][b][3] = tempAlpha*tapAlpha_Base[a][b];
                    
                    tapTexCoord[n][a][b][0] = texCoord_Base[ tapTexcoord_BaseINDEX[a][b] ][0];
                    tapTexCoord[n][a][b][1] = texCoord_Base[ tapTexcoord_BaseINDEX[a][b] ][1];
                }
            }
         
        // triangle
            
            if( yn )
            {
                glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &tapVertex[n][0][0][0] );
                glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, &tapColor[n][0][0][0] );
                glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, &tapTexCoord[n][0][0][0] );

                glDrawArrays(GL_TRIANGLES, 0, 54*3);
            }
            
            
        // Line
            //********************************************************************************
            glUseProgram(PRG_SOLID);
            glUniformMatrix4fv(UNF_mvp_Matrix, 16, GL_FALSE, MATRIX);
            //********************************************************************************
            
            
            for( a = 0 ; a < 54 ; a++ )
            {
                float tempLineAlpha;
                float randomAlpha;
                
                if( random()%5 == 0 )
                { randomAlpha = 1.0f; }
                else
                { randomAlpha = 0.0f; }
                
                if( a < 6 )
                {
                    if( TAP_DRAW_COUNTER[n] >= 2 & TAP_DRAW_COUNTER[n] < 7 )
                    {
                        tempLineAlpha = randomAlpha*0.75f;
                    }
                    else if( TAP_DRAW_COUNTER[n] >= 38-2 && TAP_DRAW_COUNTER[n] < 42-2 )
                    {
                        tempLineAlpha = randomAlpha*0.5f;
                    }
                    else
                    {
                        tempLineAlpha = 0.0f;
                    }
                }
                else if( a >= 6 && a < 24 )
                {
                    if( TAP_DRAW_COUNTER[n] >= 8 && TAP_DRAW_COUNTER[n] < 13 )
                    {
                        tempLineAlpha = randomAlpha*0.75f;
                    }
                    else if( TAP_DRAW_COUNTER[n] >= 44-2 && TAP_DRAW_COUNTER[n] < 48-2 )
                    {
                        tempLineAlpha = randomAlpha*0.5f;
                    }
                    else
                    {
                        tempLineAlpha = 0.0f;
                    }
                }
                else
                {
                    if( TAP_DRAW_COUNTER[n] > 14 && TAP_DRAW_COUNTER[n] <= 19 )
                    {
                        tempLineAlpha = randomAlpha*0.75f;
                    }
                    else if( TAP_DRAW_COUNTER[n] >= 50-2 && TAP_DRAW_COUNTER[n] < 54-2 )
                    {
                        tempLineAlpha = randomAlpha*0.5f;
                    }
                    else
                    {
                        tempLineAlpha = 0.0f;
                    }
                }
                                
                for( b = 0 ; b < 3 ; b++ )
                {                    
                    tapColor[n][a][b][0] = 1.0f;
                    tapColor[n][a][b][1] = 1.0f;
                    tapColor[n][a][b][2] = 1.0f;
                    tapColor[n][a][b][3] = tempLineAlpha;
                }
            }
            
            if(yn)
            {
                glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &tapVertex[n][0][0][0] );
                glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, &tapColor[n][0][0][0] );
            
                glDrawElements(GL_LINES, 54*6, GL_UNSIGNED_SHORT, tapDrawINDEX);
            }
            
            
            
            
            TAP_DRAW_COUNTER[n]++;
            if(TAP_DRAW_COUNTER[n] > 100)
            { isTapDraw[n] = NO; }
            
        }// isTapDraw
        
        
        
        tapCenter_Vel[n][0] = tapCenter_Vel[n][0]*0.95 - act_lookingAxis[0]*0.003 + act_PanF[0];
        tapCenter_Vel[n][1] = tapCenter_Vel[n][1]*0.95 - act_lookingAxis[1]*0.003 + act_PanF[1];
        tapCenter_Vel[n][2] = tapCenter_Vel[n][2]*0.95;
        
        tapCenter[n][0] += tapCenter_Vel[n][0];
        tapCenter[n][1] += tapCenter_Vel[n][1];
        tapCenter[n][2] += tapCenter_Vel[n][2];
    }// n

    
    act_texScale += (texScale - act_texScale)*0.1f;
    

}

@end