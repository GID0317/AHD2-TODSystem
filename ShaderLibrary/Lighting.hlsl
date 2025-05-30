//计算光照的函数
#ifndef CUSTOM_LIGHTING_INCLUDED
#define CUSTOM_LIGHTING_INCLUDED

//采样镜面反射
half3 GetSpecular(Surface surface, BRDF brdf, CartoonInputData inputdata)
{
    //float2 IBLLUT = tex2D(_PrefilteredEnvMapLUT,float2(NoV, 1- brdf.roughness)).rg;
    half3 prefilteredColor = texCUBElod(_AHD2_SpecCube0, float4(inputdata.reflectionDirWS,(brdf.roughness )* 7)).xyz;//mipmap有多少级，粗糙度就乘多少
    return prefilteredColor;
}

//返回方向光的radiance
half3 IncomingLight (Surface surface, half3 mainlightDir,half3 lightCol, half directShadow) {
    //return saturate(dot(surface.normalWS, mainlightDir)) * lightCol.xyz * lightCol.a * saturate((directShadow + 1 - 0.5 * lightCol.a));
    return saturate(dot(surface.normalWS, mainlightDir)) * lightCol.xyz * saturate(directShadow) * surface.ambientOcclusion;
}
half3 AmbientLighting(Surface surface, BRDF brdf, CartoonInputData inputdata)
{
    //ibl漫反射
    half3 Irradiance = inputdata.vertexSH;
    half3 DiffuseColor = (1.0 - surface.metallic) * surface.color; // Metallic surfaces have no diffuse reflections
    half3 DiffuseContribution =  DiffuseColor * Irradiance;//不除以pi可能是IBL图已经除以过了。
    //ibl镜面反射
    half3 prefilteredColor = GetSpecular(surface, brdf, inputdata);
    half3 SpecularContribution = prefilteredColor * EnvBRDF(surface.metallic, surface.color, brdf.iblLUT);
    //return 0;
    return (DiffuseContribution + SpecularContribution) * surface.ambientOcclusion * 2;
}

half3 GetLighting (Surface surface, BRDF brdf, CartoonInputData inputdata, half3 mainlightDir, half3 lightCol, half direcctShadow) {
	return IncomingLight(surface, mainlightDir, lightCol, direcctShadow) * DirectBRDF(surface, brdf, mainlightDir, inputdata) + AmbientLighting(surface, brdf, inputdata);
}

#endif