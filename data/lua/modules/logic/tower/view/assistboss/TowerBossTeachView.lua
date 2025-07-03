module("modules.logic.tower.view.assistboss.TowerBossTeachView", package.seeall)

local var_0_0 = class("TowerBossTeachView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseFullView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeFullView")
	arg_1_0._txttitleName = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_titleName")
	arg_1_0._simagebossIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "boss/#simage_bossIcon")
	arg_1_0._simagebossShadow = gohelper.findChildSingleImage(arg_1_0.viewGO, "boss/#simage_shadow")
	arg_1_0._txtbossDesc = gohelper.findChildText(arg_1_0.viewGO, "info/scroll_bossDesc/Viewport/Content/#txt_bossDesc")
	arg_1_0._btnskillTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "info/#btn_skillTips")
	arg_1_0._goskillTip = gohelper.findChild(arg_1_0.viewGO, "#go_skillTip")
	arg_1_0._scrollepisode = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_episode")
	arg_1_0._goepisodeContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_episode/Viewport/#go_episodeContent")
	arg_1_0._goepisodeItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_episode/Viewport/#go_episodeContent/#go_episodeItem")
	arg_1_0._goepisodeSelect = gohelper.findChild(arg_1_0.viewGO, "#go_episodeSelect")
	arg_1_0._txtepisodeDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_episodeSelect/scroll_episodeDesc/Viewport/Content/#txt_episodeDesc")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_episodeSelect/#btn_start")
	arg_1_0._txtstart = gohelper.findChildText(arg_1_0.viewGO, "#go_episodeSelect/#btn_start/txt")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseFullView:AddClickListener(arg_2_0._btncloseFullViewOnClick, arg_2_0)
	arg_2_0._btnskillTips:AddClickListener(arg_2_0._btnskillTipsOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseFullView:RemoveClickListener()
	arg_3_0._btnskillTips:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseFullViewOnClick(arg_4_0)
	arg_4_0:_btncloseOnClick()
end

function var_0_0._btnskillTipsOnClick(arg_5_0)
	if not arg_5_0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSkillTipsView, {
		bossId = arg_5_0.bossId
	})
end

function var_0_0._btnstartOnClick(arg_6_0)
	local var_6_0 = TowerConfig.instance:getBossTeachConfig(arg_6_0.towerId, arg_6_0.selectTeachId)

	if not var_6_0 then
		return
	end

	local var_6_1 = {
		towerType = arg_6_0.towerType,
		towerId = arg_6_0.towerId
	}

	var_6_1.layerId = 0
	var_6_1.episodeId = var_6_0.episodeId
	var_6_1.difficulty = var_6_0.teachId

	TowerController.instance:enterFight(var_6_1)
	TowerBossTeachModel.instance:setLastFightTeachId(var_6_0.teachId)
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onEpisodeItemClick(arg_8_0, arg_8_1)
	if arg_8_0.selectTeachId == arg_8_1.config.teachId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_main_switch_scene_2_2)

	arg_8_0.selectTeachId = arg_8_1.config.teachId

	arg_8_0:refreshSelectUI()
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.setActive(arg_9_0._goepisodeItem, false)
	NavigateMgr.instance:addEscape(ViewName.TowerBossTeachView, arg_9_0.closeThis, arg_9_0)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play__ui_main_fit_scane_2_2)
	arg_11_0:initData()
	arg_11_0:refreshUI()
end

function var_0_0.initData(arg_12_0)
	arg_12_0.towerType = arg_12_0.viewParam.towerType
	arg_12_0.towerId = arg_12_0.viewParam.towerId
	arg_12_0.towerConfig = TowerConfig.instance:getBossTowerConfig(arg_12_0.towerId)
	arg_12_0.bossConfig = TowerConfig.instance:getAssistBossConfig(arg_12_0.towerConfig.bossId)
	arg_12_0.bossId = arg_12_0.towerConfig.bossId
	arg_12_0.skinConfig = FightConfig.instance:getSkinCO(arg_12_0.bossConfig.skinId)
	arg_12_0.towerInfo = TowerModel.instance:getTowerInfoById(arg_12_0.towerType, arg_12_0.towerId)
	arg_12_0.lastFightTeachId = arg_12_0.viewParam.lastFightTeachId or 0
	arg_12_0.episodeItemMap = arg_12_0:getUserDataTb_()
	arg_12_0.allTeachConfigList = TowerConfig.instance:getAllBossTeachConfigList(arg_12_0.towerId)
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0._simagebossIcon:LoadImage(arg_13_0.bossConfig.bossPic)
	arg_13_0._simagebossShadow:LoadImage(arg_13_0.bossConfig.bossShadowPic)

	arg_13_0._txttitleName.text = arg_13_0.towerConfig.name
	arg_13_0._txtbossDesc.text = arg_13_0.bossConfig.bossDesc

	arg_13_0:createAndRefreshEpisodeItem()
	arg_13_0:refreshSelectUI()
end

function var_0_0.createAndRefreshEpisodeItem(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.allTeachConfigList) do
		local var_14_0 = arg_14_0.episodeItemMap[iter_14_1.teachId]

		if not var_14_0 then
			var_14_0 = {
				config = iter_14_1
			}
			var_14_0.isFinish = false
			var_14_0.go = gohelper.cloneInPlace(arg_14_0._goepisodeItem)
			var_14_0.simageBoss = gohelper.findChildSingleImage(var_14_0.go, "boss/image_boss")
			var_14_0.goSelect = gohelper.findChild(var_14_0.go, "go_select")
			var_14_0.txtEpisodeName = gohelper.findChildText(var_14_0.go, "name/txt_episodeName")
			var_14_0.goFinishIcon = gohelper.findChild(var_14_0.go, "name/txt_episodeName/go_finishIcon")
			var_14_0.btnClick = gohelper.findChildClickWithAudio(var_14_0.go, "btn_click")

			var_14_0.btnClick:AddClickListener(arg_14_0.onEpisodeItemClick, arg_14_0, var_14_0)

			arg_14_0.episodeItemMap[iter_14_1.teachId] = var_14_0
		end

		gohelper.setActive(var_14_0.go, true)
		var_14_0.simageBoss:LoadImage(ResUrl.monsterHeadIcon(arg_14_0.skinConfig and arg_14_0.skinConfig.headIcon))

		var_14_0.txtEpisodeName.text = iter_14_1.name
		var_14_0.isFinish = arg_14_0.towerInfo:isPassBossTeach(iter_14_1.teachId)

		gohelper.setActive(var_14_0.goFinishIcon, var_14_0.isFinish)
	end

	if not arg_14_0.selectTeachId then
		arg_14_0.selectTeachId = arg_14_0.lastFightTeachId > 0 and arg_14_0.lastFightTeachId or TowerBossTeachModel.instance:getFirstUnFinishTeachId(arg_14_0.bossId)
	end
end

function var_0_0.refreshSelectUI(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.episodeItemMap) do
		gohelper.setActive(iter_15_1.goSelect, iter_15_1.config.teachId == arg_15_0.selectTeachId)

		local var_15_0 = iter_15_1.config.teachId == arg_15_0.selectTeachId and 1 or 0.9

		transformhelper.setLocalScale(iter_15_1.go.transform, var_15_0, var_15_0, var_15_0)
	end

	gohelper.setActive(arg_15_0._goepisodeSelect, true)

	local var_15_1 = TowerConfig.instance:getBossTeachConfig(arg_15_0.towerId, arg_15_0.selectTeachId)

	arg_15_0._txtepisodeDesc.text = var_15_1 and var_15_1.desc or ""
	arg_15_0._txtstart.text = arg_15_0.episodeItemMap[arg_15_0.selectTeachId].isFinish and luaLang("towerbossteachpass") or luaLang("towerbossteachstart")
end

function var_0_0.onClose(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.episodeItemMap) do
		iter_16_1.btnClick:RemoveClickListener()
		iter_16_1.simageBoss:UnLoadImage()
	end

	arg_16_0._simagebossIcon:UnLoadImage()
	arg_16_0._simagebossShadow:UnLoadImage()
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
