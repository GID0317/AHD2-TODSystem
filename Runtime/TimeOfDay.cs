using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

namespace AHD2TimeOfDay
{
    /// <summary>
    /// 单个时刻的父类。子类为一天中的单个时刻
    /// </summary>
    [CreateAssetMenu(fileName = "TOD", menuName = "AHD2TODSystem/TimeOfDay", order = 5)]
    public class TimeOfDay : ScriptableObject
    {
        public TimeOfDay nextTOD; //下一个时刻
        public float CurrentTODTime; //当前时刻的代表时间
        public float NextTODTime; //下一时刻的代表时间(时间范围为[0,24)，即24点统一用0点)
        [HideInInspector] public bool isCross24; //这个时刻和下个时刻中间是否越过24点

        [HideInInspector] public float duration; //这个TOD到下个TOD的间隔时长

        //光源
        public Color MainlightColor;
        public float MainlightIntensity;
        public float MainlightAngle;//真光源方向，影响方向光的(只表示绕x轴旋转一圈，要想倾斜需要修改全局参数的MainlightTiltAngle)
        
        //雾效
        public Color FogLightColor;
        public float FogLightIntensity;
        public float HGCoefficient;
        
        [FormerlySerializedAs("datOrNight")] [Tooltip("勾选为night，不勾选为day")]
        public bool dayOrNight; //0为白天，1为黑夜

        public Material[] materials;

        public void Initialize()
        {
            isCross24 = CurrentTODTime > NextTODTime; //用代码判断它会不会越过24
            //Debug.Log(IsCrossing24);
            if (isCross24)
            {
                duration = 24 - (CurrentTODTime - NextTODTime);
            }
            else
            {
                duration = NextTODTime - CurrentTODTime;
            }
        }
    }
}