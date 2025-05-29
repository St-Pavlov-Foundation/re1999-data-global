module("modules.logic.summon.view.preloadConfig.SummonCharacterProbUpPreloadConfig", package.seeall)

local var_0_0 = class("SummonCharacterProbUpPreloadConfig")

var_0_0.preloadLists = {}
var_0_0.characterItemCounts = {}

function var_0_0.getPreLoadListByName(arg_1_0)
	return var_0_0.preloadLists[arg_1_0] or nil
end

function var_0_0.getCharacterItemCountByName(arg_2_0)
	return var_0_0.characterItemCounts[arg_2_0] or 1
end

var_0_0.preloadLists.SummonCharacterProbUpVer269 = {
	"singlebg/summon/heroversion_2_6/v2a6_lake/v2a6_lake_fulldec.png",
	"singlebg/summon/heroversion_2_6/v2a6_lake/v2a6_lake_role1.png",
	"singlebg/summon/heroversion_2_6/v2a6_lake/v2a6_lake_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer268 = {
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg2.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_role1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer267 = {
	"singlebg/summon/heroversion_1_2/yaxian/v1a2_yaxian_summon_fontbg.png",
	"singlebg/summon/heroversion_1_2/yaxian/v1a2_yaxian_summon_role1.png",
	"singlebg/summon/heroversion_1_2/yaxian/v1a2_yaxian_summon_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer266 = {
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_frontbg1.png",
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer265 = {
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_dec4.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_role1.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer264 = {
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_decbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_rolebg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer263 = {
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec2.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec1.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_role.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer262 = {
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role4.png",
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_summon_role3.png",
	"singlebg/summon/heroversion_2_6/dicehero/v2a6_dicehero_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer261 = {
	"singlebg/summon/heroversion_2_6/xugouji/v2a6_xugouji_fontbg2.png",
	"singlebg/summon/heroversion_2_6/xugouji/v2a6_xugouji_role.png",
	"singlebg/summon/heroversion_2_6/xugouji/v2a6_xugouji_fullbg.png"
}
var_0_0.preloadLists.SummonStrongOneCustomPick24 = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role2.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role3.png"
}
var_0_0.preloadLists.SummonStrongOneCustomPick25 = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_5/v2a5_selfselectsix2/v2a5_selfselectsix_role.png"
}
var_0_0.preloadLists.SummonStrongOneCustomPick26 = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_6/v2a6_selfselectsix_role.png",
	"singlebg/summon/heroversion_2_4/v2a4_selfselectsix/v2a4_selfselectsix_role1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer251 = {
	"singlebg/summon/heroversion_2_5/v2a5_liangyue/v2a5_summon_liangyue_fontbg.png",
	"singlebg/summon/heroversion_2_5/v2a5_liangyue/v2a5_summon_liangyue_role.png",
	"singlebg/summon/heroversion_2_5/v2a5_liangyue/v2a5_summon_liangyue_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer111 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg"),
	ResUrl.getSummonCoverBg("heroversion_1_1/bg_zsz")
}
var_0_0.preloadLists.SummonCharacterProbUpVer112 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg1"),
	ResUrl.getSummonCoverBg("heroversion_1_1/fg")
}
var_0_0.preloadLists.SummonCharacterProbUpVer113 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_hnj"),
	ResUrl.getSummonCoverBg("heroversion_1_1/hongnujian/img_role_hongnujian")
}
var_0_0.preloadLists.SummonCharacterProbUpVer114 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_bfz"),
	ResUrl.getSummonCoverBg("heroversion_1_1/baifuzhang/img_role_baifuzhang")
}
var_0_0.preloadLists.SummonCharacterProbUpVer115 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_xt"),
	ResUrl.getSummonCoverBg("heroversion_1_1/xingti/img_role_xingti")
}
var_0_0.preloadLists.SummonCharacterProbUpVer116 = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_fjs")
}
var_0_0.preloadLists.SummonCharacterProbUpVer121 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/wenni/full/img_bg")
}
var_0_0.preloadLists.SummonCharacterProbUpVer122 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/xinbabieta/full/img_bg")
}
var_0_0.preloadLists.SummonCharacterProbUpVer123 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/yuanlv/full/img_bg")
}
var_0_0.preloadLists.SummonCharacterProbUpVer124 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/full/bg"),
	ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/full/img_qianjing")
}
var_0_0.preloadLists.SummonCharacterProbUpVer125 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/full/img_bg"),
	ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/img_qianjing")
}
var_0_0.preloadLists.SummonCharacterProbUpVer126 = {
	ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/full/bg_da"),
	ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/bg_zhezhao")
}
var_0_0.preloadLists.SummonCharacterProbUpVer131 = {
	ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/full/v1a3_rabbit_bg")
}
var_0_0.preloadLists.SummonCharacterProbUpVer132 = {
	ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_full"),
	ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_light"),
	ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_middle")
}
var_0_0.preloadLists.SummonCharacterProbUpVer133 = {
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_bg"),
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_bg1"),
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_dec")
}
var_0_0.preloadLists.SummonCharacterProbUpVer141 = {
	"singlebg/summon/heroversion_1_4/fourroles/full/v1a4_fourroles_summon_bg.png",
	"singlebg/summon/heroversion_1_4/fourroles/v1a4_fourroles_bottombg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer142 = {
	ResUrl.getSummonCoverBg("heroversion_1_4/role37/full/v1a4_role37_summon_bg")
}
var_0_0.preloadLists.SummonCharacterProbUpVer143 = {
	"singlebg/summon/heroversion_1_4/role6/full/v1a4_role6_summon_bg.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_summon_6.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_bottombg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer144 = {
	"singlebg/summon/heroversion_1_1/full/bg_xt.png",
	"singlebg/summon/heroversion_1_1/xingti/img_role_xingti.png",
	"singlebg/summon/hero/bg_1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer145 = {
	"singlebg/summon/hero/full/bg111.png",
	"singlebg/summon/hero/role3.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer146 = {
	"singlebg/summon/heroversion_1_1/full/bg_fjs.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer151 = {
	"singlebg/summon/heroversion_1_5/rolekerandian/full/v1a5_rolekerandian_summon_bg.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_kerandian_middlebg.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_rolekerandian_summon_role1.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_kerandian_fontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer152 = {
	"singlebg/summon/heroversion_1_5/v1a5_yaxian/v1a5_yaxian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_5/v1a5_yaxian/v1a5_yaxian_summon_role2.png",
	"singlebg/summon/heroversion_1_5/v1a5_yaxian/v1a5_yaxian_summon_fontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer153 = {
	"singlebg/summon/heroversion_1_5/v1a5_baifuzhang/v1a5_baifuzhang_summon_fullbg.png",
	"singlebg/summon/heroversion_1_1/baifuzhang/img_role_baifuzhang.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer154 = {
	"singlebg/summon/heroversion_1_5/aizila/full/v1a5_roleaizila_summon_fullbg.png",
	"singlebg/summon/heroversion_1_5/aizila/v1a5_roleaizila_summon_role3.png",
	"singlebg/summon/heroversion_1_5/aizila/v1a5_aizila_fontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer155 = {
	"singlebg/summon/heroversion_1_5/v1a5_weixiukai/v1a5_weixiukai_summon_fullbg.png",
	"singlebg/summon/heroversion_1_5/v1a5_weixiukai/v1a5_weixiukai_summon_frontbg.png",
	"singlebg/summon/heroversion_1_5/v1a5_weixiukai/v1a5_roleweixiukai_summon_role1.png",
	"singlebg/summon/hero/full/mask.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer161 = {
	"singlebg/summon/heroversion_1_6/getian/full/v1a6_getian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_6/getian/v1a6_getian_summon_role1.png",
	"singlebg/summon/heroversion_1_6/getian/v1a6_getian_summon_fontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer162 = {
	"singlebg/summon/heroversion_1_6/quniang/full/v1a6_quniang_summon_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer163 = {
	"singlebg/summon/heroversion_1_6/v1a6_meilanni/v1a6_rolemeilanni_summon_fullbg.png",
	"singlebg/summon/heroversion_1_1/bg_zsz.png",
	"singlebg/summon/heroversion_1_6/v1a6_meilanni/v1a6_rolemeilanni_summon_role1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer164 = {
	"singlebg/summon/heroversion_1_6/v1a6_pikelesi/v1a6_pikelesi_summon_fullbg.png",
	"singlebg/summon/heroversion_1_6/v1a6_pikelesi/v1a6_pikelesi_summon_caidaibg.png",
	"singlebg/summon/heroversion_1_6/v1a6_pikelesi/v1a6_rolepikelesi_summon_role1.png",
	"singlebg/summon/heroversion_1_6/v1a6_pikelesi/v1a6_pikelesi_summon_frontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer165 = {
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_fullbg.png",
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_role1.png",
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_middlebg.png",
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_lightbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer171 = {
	"singlebg/summon/heroversion_1_7/yisuerde/full/bg.png",
	"singlebg/summon/heroversion_1_7/yisuerde/yisuoerde.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer172 = {
	"singlebg/summon/heroversion_1_7/makusi/full/v1a7_makusi_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer173 = {
	"singlebg/summon/heroversion_1_7/37/full/v1a7_37_fullbg.png",
	"singlebg/summon/heroversion_1_4/role37/v1a4_role37_summon_37.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer174 = {
	"singlebg/summon/heroversion_1_7/jiexika/full/v1a7_jiexika_fullbg.png",
	"singlebg/summon/heroversion_1_7/jiexika/v1a7_rolejiexika.png",
	"singlebg/summon/heroversion_1_7/jiexika/full/v1a7_jiexika_frontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer175 = {
	"singlebg/summon/heroversion_1_7/v1a7_role6/v1a7_role6_summon_fullbg.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_summon_6.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_bottombg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer181 = {
	"singlebg/summon/heroversion_1_3/galapona/full/v1a3_galapona_bg.png",
	"singlebg/summon/heroversion_1_8/v1a8_jialabona/v1a8_jialabona_summon_dec2.png",
	"singlebg/summon/heroversion_1_8/v1a8_jialabona/v1a8_jialabona_summon_dec1.png",
	"singlebg/summon/heroversion_1_3/galapona/v1a3_galapona_role1.png",
	"singlebg/summon/heroversion_1_3/galapona/full/v1a3_galapona_dec.png",
	"singlebg/summon/heroversion_1_3/galapona/v1a3_galapona_line1.png",
	"singlebg/summon/heroversion_1_3/galapona/v1a3_galapona_line3.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer182 = {
	"singlebg/summon/heroversion_1_8/v1a8_role6/v1a8_role6_summon_fullbg.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_summon_6.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_bottombg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer183 = {
	"singlebg/summon/heroversion_1_1/full/bg_xt.png",
	"singlebg/summon/hero/3025.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer184 = {
	"singlebg/summon/heroversion_1_8/v1a8_windsong/v1a8_windsong_summon_fullbg.png",
	"singlebg/summon/heroversion_1_8/v1a8_windsong/v1a8_windsong_summon_role1.png",
	"singlebg/summon/heroversion_1_8/v1a8_windsong/v1a8_windsong_summon_dec2.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer185 = {
	"singlebg/summon/heroversion_1_8/v1a8_weila/v1a8_weila_fullbg.png",
	"singlebg/summon/heroversion_1_8/v1a8_weila/v1a8_weila_role1.png",
	"singlebg/summon/heroversion_1_8/v1a8_weila/v1a8_weila_frontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer186 = {
	"singlebg/summon/heroversion_1_5/rolekerandian/full/v1a5_rolekerandian_summon_bg.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_kerandian_middlebg.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_rolekerandian_summon_role1.png",
	"singlebg/summon/heroversion_1_5/rolekerandian/v1a5_kerandian_fontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer191 = {
	"singlebg/summon/heroversion_1_9/kakaniya/v1a9_kakaniya_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer192 = {
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_fullbg.png",
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_decbg1.png",
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_rolebg.png",
	"singlebg/summon/heroversion_1_9/lucy/v1a9_lucy_decbg2.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer193 = {
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_role1.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer194 = {
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_role1.png",
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_fontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer195 = {
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_role1.png",
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_mask.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer201 = {
	"singlebg/summon/heroversion_2_0/joe/full/v2a0_joe_fullbg.png",
	"singlebg/summon/heroversion_2_0/joe/v2a0_joe_role1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer202 = {
	"singlebg/summon/heroversion_2_0/mercury/full/v2a0_mercury_fullbg.png",
	"singlebg/summon/heroversion_2_0/mercury/v2a0_mercury_role1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer203 = {
	"singlebg/summon/heroversion_2_0/yisuerde/full/v2a0_yisuoerde_fullbg.png",
	"singlebg/summon/heroversion_2_0/yisuerde/v2a0_yisuoerde_role1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer204 = {
	"singlebg/summon/heroversion_2_0/galapona/full/v2a0_galapona_bg.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec2.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec2.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_role1.png",
	"singlebg/summon/heroversion_2_0/galapona/full/v2a0_galapona_dec.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_line1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_line3.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer205 = {
	"singlebg/summon/heroversion_2_0/aizila/full/v2a0_roleaizila_summon_fullbg.png",
	"singlebg/summon/heroversion_2_0/aizila/v2a0_roleaizila_summon_role3.png",
	"singlebg/summon/heroversion_2_0/aizila/v2a0_aizila_fontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer211 = {
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_fullbg.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_role1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg2.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer212 = {
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_fullbg.png",
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_role1.png",
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_dec2.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer213 = {
	"singlebg/summon/heroversion_2_1/makusi/full/v2a1_makusi_fullbg.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_role3.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_middlebg.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_frontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer214 = {
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_fullbg.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_role1.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_frontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer215 = {
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_fullbg.png",
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_frontbg1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer221 = {
	"singlebg/summon/heroversion_2_2/v2a2_tianshinana/v2a2_tianshinana_fullbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_tianshinana/v2a2_tianshinana_rolebg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer222 = {
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_fullbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_rolebg.png",
	"singlebg/summon/heroversion_2_2/v2a2_luopeila/v2a2_luopeila_decbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer223 = {
	"singlebg/summon/heroversion_2_2/v2a2_yisuerde/full/v2a2_yisuoerde_fullbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_yisuerde/v2a2_yisuoerde_role1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer224 = {
	"singlebg/summon/heroversion_2_2/v2a2_role6/v2a2_role6_summon_fullbg.png",
	"singlebg/summon/heroversion_2_2/v2a2_role6/v2a2_role6_summon_6.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer225 = {
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_role1.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer231 = {
	"singlebg/summon/heroversion_1_9/kakaniya/v1a9_kakaniya_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer232 = {
	"singlebg/summon/heroversion_2_0/joe/full/v2a0_joe_fullbg.png",
	"singlebg/summon/heroversion_2_0/joe/v2a0_joe_role1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer233 = {
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_fullbg.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_role.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec1.png",
	"singlebg/summon/heroversion_2_3/dudugu/v2a3_dudugu_dec2.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer234 = {
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_fullbg.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_role1.png",
	"singlebg/summon/heroversion_2_3/zhixinquaner/v2a3_summon_zhixinquaner_dec4.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer235 = {
	"singlebg/summon/heroversion_2_0/mercury/full/v2a0_mercury_fullbg.png",
	"singlebg/summon/heroversion_2_0/mercury/v2a0_mercury_role1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer241 = {
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_decbg1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer242 = {
	"singlebg/summon/heroversion_2_4/v2a4_tutushizi/v2a4_summon_tutushizi_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_tutushizi/v2a4_summon_tutushizi_role1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer243 = {
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_fullbg.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_role1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg1.png",
	"singlebg/summon/heroversion_2_1/aergusi/v2a1_aergusi_frontbg2.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer244 = {
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_fullbg.png",
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_role1.png",
	"singlebg/summon/heroversion_2_1/windsong/v2a1_windsong_summon_dec2.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer252 = {
	"singlebg/summon/heroversion_2_5/v2a5_feilinshiduo/v2a5_summon_feilinshiduo_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_bakaluoer/v2a4_summon_bakaluoer_decbg1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer253 = {
	"singlebg/summon/heroversion_1_6/quniang/full/v1a6_quniang_summon_fullbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer254 = {
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_fullbg.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_role1.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_frontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer255 = {
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_fullbg.png",
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_frontbg1.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVer256 = {
	"singlebg/summon/heroversion_2_1/makusi/full/v2a1_makusi_fullbg.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_role3.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_middlebg.png",
	"singlebg/summon/heroversion_2_1/makusi/v2a1_makusi_frontbg.png"
}
var_0_0.preloadLists.SummonCharacterProbUpVerBeta1 = {
	ResUrl.getSummonCoverBg("hero/full/bg2"),
	ResUrl.getSummonCoverBg("hero/full/mask"),
	ResUrl.getSummonCoverBg("hero/leftdown"),
	ResUrl.getSummonCoverBg("hero/rightup")
}
var_0_0.characterItemCounts.SummonCharacterProbUpVer269 = 2
var_0_0.characterItemCounts.SummonCharacterProbUpVer112 = 2
var_0_0.characterItemCounts.SummonCharacterProbUpVer124 = 2
var_0_0.characterItemCounts.SummonCharacterProbUpVer125 = 2
var_0_0.characterItemCounts.SummonCharacterProbUpVer132 = 2
var_0_0.characterItemCounts.SummonCharacterProbUpVer141 = 4
var_0_0.characterItemCounts.SummonCharacterProbUpVer151 = 2
var_0_0.characterItemCounts.SummonCharacterProbUpVer154 = 2
var_0_0.characterItemCounts.SummonCharacterProbUpVer185 = 2
var_0_0.characterItemCounts.SummonCharacterProbUpVer215 = 2
var_0_0.characterItemCounts.SummonCharacterProbUpVer234 = 2

return var_0_0
