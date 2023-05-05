
#import "M04_Kaleidoscope.h"

@implementation M04_Kaleidoscope ( DRAW_LONGPRESS )

- (void)drawLongPress
{
    int I, J, K;
    
    
    glUseProgram( PRG_FBO_DRAW );
    glUniformMatrix4fv(UNF_mvp_Matrix, 16, GL_FALSE, MATRIX);

    float F[3];
    float vecTo[3];
    float distance;
    float distWeight;
    float tempTexCoord[3][2];
    
    for( I = 0 ; I < 4 ; I++ )
    {
        float size = (1.0 - act_LP_afterAlpha[I] + 0.1) * 0.4; // 0.1 - 1.1
        
        tempTexCoord[0][0] = (0.5 + cosf(M_PI_2 + I*2.0f)*size);
        tempTexCoord[0][1] = (0.5 + sinf(M_PI_2 + I*2.0f)*size);
        tempTexCoord[1][0] = (0.5 + cosf(M_PI_2 + 120.0f * 0.0174532925f + I*2.0f)*size);
        tempTexCoord[1][1] = (0.5 + sinf(M_PI_2 + 120.0f * 0.0174532925f + I*2.0f)*size);
        tempTexCoord[2][0] = (0.5 + cosf(M_PI_2 + 240.0f * 0.0174532925f + I*2.0f)*size);
        tempTexCoord[3][1] = (0.5 + sinf(M_PI_2 + 240.0f * 0.0174532925f + I*2.0f)*size);

        for( J = 0 ; J < 54 ; J++ )
        {
            for( K = 0 ; K < 3 ; K++ )
            {
                vecTo[0] = ( (LP_Center[I][0] + tapVertex_Base[J][K][0]) - act_LP_Vertex[I][J][K][0]);
                vecTo[1] = ( (LP_Center[I][1] + tapVertex_Base[J][K][1]) - act_LP_Vertex[I][J][K][1]);
                vecTo[2] = ( LP_Center[I][2] - act_LP_Vertex[I][J][K][2] );
                
                distance = sqrtf( vecTo[0]*vecTo[0] + vecTo[1]*vecTo[1] + vecTo[2]*vecTo[2] );
                distWeight = 1.0 / distance;
                
                distance = sqrtf(distance);
                
                vecTo[0] *= distWeight;
                vecTo[1] *= distWeight;
                vecTo[2] *= distWeight;
                
                F[0] = vecTo[0]*distance*0.005f + act_PanF[0];
                F[1] = vecTo[1]*distance*0.005f + act_PanF[1];
                F[2] = vecTo[2]*distance*0.005f;
                
       // Stock Vertex Data
                for( int l = 5 ; l >= 1 ; l-- )
                {
                    act_LP_VStock[l][I][J][K][0] = act_LP_VStock[l-1][I][J][K][0];
                    act_LP_VStock[l][I][J][K][1] = act_LP_VStock[l-1][I][J][K][1];
                    act_LP_VStock[l][I][J][K][2] = act_LP_VStock[l-1][I][J][K][2];
                    act_LP_VStock[l][I][J][K][3] = act_LP_VStock[l-1][I][J][K][3];
                }
                
                act_LP_VStock[0][I][J][K][0] = act_LP_Vertex[I][J][K][0];
                act_LP_VStock[0][I][J][K][1] = act_LP_Vertex[I][J][K][1];
                act_LP_VStock[0][I][J][K][2] = act_LP_Vertex[I][J][K][2];
                act_LP_VStock[0][I][J][K][3] = act_LP_Vertex[I][J][K][3];
     // Stock Vertex Data   
                
                
                
                act_LP_velocity[I][J][K][0] = act_LP_velocity[I][J][K][0]*0.97f + F[0];
                act_LP_velocity[I][J][K][1] = act_LP_velocity[I][J][K][1]*0.97f + F[1];
                act_LP_velocity[I][J][K][2] = act_LP_velocity[I][J][K][2]*0.97f + F[2];
                
                act_LP_Vertex[I][J][K][0] += act_LP_velocity[I][J][K][0];
                act_LP_Vertex[I][J][K][1] += act_LP_velocity[I][J][K][1];
                act_LP_Vertex[I][J][K][2] += act_LP_velocity[I][J][K][2];
                // w is already set;
                
                act_LP_Color[I][J][K][0] = 0.0f;
                act_LP_Color[I][J][K][1] = 0.0f;
                act_LP_Color[I][J][K][2] = 0.0f;
                act_LP_Color[I][J][K][3] = 1.0f * tapAlpha_Base[J][K] * act_LP_afterAlpha[I];
                
                //LP_TexCoord[54][3][2]
                
                LP_TexCoord[J][K][0] = tempTexCoord[tapTexcoord_BaseINDEX[J][K]][0];
                LP_TexCoord[J][K][1] = tempTexCoord[tapTexcoord_BaseINDEX[J][K]][1];
                
            } // K
        } // J
        
            glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &act_LP_Vertex[I][0][0][0] );
            glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, &act_LP_Color[I][0][0][0] );
            glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, LP_TexCoord);
            glDrawArrays(GL_TRIANGLES, 0, 54*3 );
            
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &act_LP_VStock[1][I][0][0][0] );
        glDrawArrays(GL_TRIANGLES, 0, 54*3 );
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &act_LP_VStock[3][I][0][0][0] );
        glDrawArrays(GL_TRIANGLES, 0, 54*3 );
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &act_LP_VStock[5][I][0][0][0] );
        glDrawArrays(GL_TRIANGLES, 0, 54*3 );
    
        if (!isLongPressed[I])
        {
            act_LP_afterAlpha[I] += ( 0.0f - act_LP_afterAlpha[I] )*0.05f;
        }
    } // I 4
    
}

@end