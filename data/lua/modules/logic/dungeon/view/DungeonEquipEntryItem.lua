module("modules.logic.dungeon.view.DungeonEquipEntryItem", package.seeall)

local var_0_0 = class("DungeonEquipEntryItem", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "coverInfo/title/#txt_title")
	arg_1_0._txttitleEn = gohelper.findChildText(arg_1_0.viewGO, "coverInfo/title/#txt_titleEn")
	arg_1_0._simagecoverpic = gohelper.findChildSingleImage(arg_1_0.viewGO, "coverInfo/#simage_coverpic")
	arg_1_0._txtcoverDesc = gohelper.findChildText(arg_1_0.viewGO, "coverInfo/#txt_coverDesc")
	arg_1_0._imagefill = gohelper.findChildImage(arg_1_0.viewGO, "coverInfo/progress/#image_fill")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "coverInfo/progress/#txt_progress")
	arg_1_0._txttype = gohelper.findChildText(arg_1_0.viewGO, "detailInfo/clue/#txt_type")
	arg_1_0._txttypeNameEn = gohelper.findChildText(arg_1_0.viewGO, "detailInfo/clue/#txt_type/#txt_typeNameEn")
	arg_1_0._txtclueName = gohelper.findChildText(arg_1_0.viewGO, "detailInfo/clue/#txt_clueName")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "detailInfo/clue/#simage_pic")
	arg_1_0._txtclueDesc = gohelper.findChildText(arg_1_0.viewGO, "detailInfo/desc/#txt_clueDesc")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "detailInfo/#go_reward")
	arg_1_0._gocomplate = gohelper.findChild(arg_1_0.viewGO, "detailInfo/#go_complate")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "detailInfo/#go_reward/#scroll_reward")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "detailInfo/#go_reward/#scroll_reward/#btn_reward")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "detailInfo/#go_reward/#scroll_reward/Viewport/Content/#go_item")
	arg_1_0._btnsurveybtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "detailInfo/#go_reward/#btn_surveybtn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsurveybtn:AddClickListener(arg_2_0._btnsurveybtnOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsurveybtn:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
end

function var_0_0._btnsurveybtnOnClick(arg_4_0)
	DungeonFightController.instance:enterFight(arg_4_0._config.chapterId, arg_4_0._episodeId)
end

function var_0_0._btnrewardOnClick(arg_5_0)
	DungeonController.instance:openDungeonRewardView(arg_5_0._config)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._config = DungeonConfig.instance:getEpisodeCO(arg_6_0._episodeId)

	arg_6_0._simagebg1:LoadImage(ResUrl.getDungeonIcon("entry/bg_teshufuben_diban"))
	arg_6_0._simagebg2:LoadImage(ResUrl.getDungeonIcon("entry/bg_teshufuben_zhuangshi"))

	arg_6_0._txttitle.text = arg_6_0._config.name
	arg_6_0._txttitleEn.text = arg_6_0._config.name_En
	arg_6_0._txtclueDesc.text = string.format("          %s", arg_6_0._config.battleDesc)
	arg_6_0._txtcoverDesc.text = arg_6_0._config.desc

	local var_6_0 = {
		arg_6_0._progress - 1,
		arg_6_0._episodeNum
	}

	arg_6_0._txtprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeon_map_sp_equip_progress"), var_6_0)
	arg_6_0._imagefill.fillAmount = (arg_6_0._progress - 1) / arg_6_0._episodeNum

	local var_6_1 = DungeonModel.instance:getEpisodeInfo(arg_6_0._episodeId)
	local var_6_2 = DungeonModel.instance:hasPassLevel(arg_6_0._episodeId) and var_6_1.challengeCount == 1

	gohelper.setActive(arg_6_0._goreward, not var_6_2)
	gohelper.setActive(arg_6_0._gocomplate, var_6_2)

	local var_6_3 = arg_6_0._config.navigationpic

	arg_6_0._simagecoverpic:LoadImage(ResUrl.getDungeonIcon(string.format("entry/bg_%s_%s", var_6_3, 1)))
	arg_6_0._simagepic:LoadImage(ResUrl.getDungeonIcon(string.format("entry/bg_%s_%s", var_6_3, 2)))

	local var_6_4 = DungeonModel.instance:getEpisodeRewardDisplayList(arg_6_0._episodeId)

	for iter_6_0, iter_6_1 in ipairs(var_6_4) do
		local var_6_5 = gohelper.cloneInPlace(arg_6_0._goitem)

		gohelper.setActive(var_6_5, true)

		local var_6_6 = IconMgr.instance:getCommonPropItemIcon(var_6_5)

		var_6_6:setMOValue(iter_6_1[1], iter_6_1[2], iter_6_1[3])
		var_6_6:isShowEquipAndItemCount(false)
		var_6_6:hideEquipLvAndBreak(true)
	end
end

function var_0_0.ctor(arg_7_0, arg_7_1)
	arg_7_0._episodeIndex = arg_7_1[1]
	arg_7_0._episodeNum = arg_7_1[2]
	arg_7_0._episodeId = arg_7_1[3]
	arg_7_0._progress = arg_7_1[4]
end

function var_0_0.init(arg_8_0, arg_8_1)
	arg_8_0.viewGO = arg_8_1

	arg_8_0:onInitView()
	arg_8_0:addEvents()
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	return
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0:removeEvents()
	arg_12_0._simagebg1:UnLoadImage()
	arg_12_0._simagebg2:UnLoadImage()
	arg_12_0._simagecoverpic:UnLoadImage()
	arg_12_0._simagepic:UnLoadImage()
end

return var_0_0
