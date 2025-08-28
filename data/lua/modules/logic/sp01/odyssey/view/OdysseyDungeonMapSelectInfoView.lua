module("modules.logic.sp01.odyssey.view.OdysseyDungeonMapSelectInfoView", package.seeall)

local var_0_0 = class("OdysseyDungeonMapSelectInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtmapName = gohelper.findChildText(arg_1_0.viewGO, "root/title/#txt_mapName")
	arg_1_0._simagemap = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_map")
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_info")
	arg_1_0._goexploreBar = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/explore/#go_exploreBar")
	arg_1_0._txtexplore = gohelper.findChildText(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/explore/txt/#txt_explore")
	arg_1_0._txtrecommendLevel = gohelper.findChildText(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/recommendLevel/txt/#txt_recommendLevel")
	arg_1_0._gotask = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/#go_task")
	arg_1_0._txttask = gohelper.findChildText(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/#go_task/taskContent/#txt_task")
	arg_1_0._goconquer = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/#go_conquer")
	arg_1_0._txtconquer = gohelper.findChildText(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/#go_conquer/#txt_conquer")
	arg_1_0._gomyth = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/#go_myth")
	arg_1_0._imagemythResult = gohelper.findChildImage(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/#go_myth/txt/#image_mythResult")
	arg_1_0._txtmyth = gohelper.findChildText(arg_1_0.viewGO, "root/#scroll_info/Viewport/Content/#go_myth/#txt_myth")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_enter")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "root/#go_lock")
	arg_1_0._txtlock = gohelper.findChildText(arg_1_0.viewGO, "root/#go_lock/#txt_lock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.DailyRefresh, arg_2_0.dailyRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenter:RemoveClickListener()
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.DailyRefresh, arg_3_0.dailyRefresh, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshLockDesc, arg_3_0)
end

function var_0_0._btnenterOnClick(arg_4_0)
	OdysseyDungeonModel.instance:setCurMapId(arg_4_0.mapId)
	OdysseyDungeonModel.instance:setIsMapSelect(false)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnMapSelectItemEnter)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.anim = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._imageExploreBar = arg_5_0._goexploreBar:GetComponent(gohelper.Type_Image)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:initData()
	arg_6_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_unfold)

	arg_6_0.anim.enabled = true

	arg_6_0.anim:Play("open", 0, 0)
	arg_6_0.anim:Update(0)
end

function var_0_0.onOpen(arg_7_0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowDungeonRightUI, false)
	arg_7_0:initData()
	arg_7_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_unfold)
end

function var_0_0.dailyRefresh(arg_8_0)
	arg_8_0:initData()
	arg_8_0:refreshUI()
end

function var_0_0.initData(arg_9_0)
	arg_9_0.mapId = arg_9_0.viewParam.mapId
	arg_9_0.mapConfig = OdysseyConfig.instance:getDungeonMapConfig(arg_9_0.mapId)
	arg_9_0.mapMo = OdysseyDungeonModel.instance:getMapInfo(arg_9_0.mapId)
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0._scrollinfo.verticalNormalizedPosition = 1
	arg_10_0._txtmapName.text = arg_10_0.mapConfig.mapName
	arg_10_0._txtexplore.text = arg_10_0.mapMo and string.format("%s%%", math.floor(arg_10_0.mapMo.exploreValue / 10)) or "???"
	arg_10_0._imageExploreBar.fillAmount = arg_10_0.mapMo and arg_10_0.mapMo.exploreValue / 1000 or 0

	local var_10_0 = string.splitToNumber(arg_10_0.mapConfig.recommendLevel, "#")

	arg_10_0._txtrecommendLevel.text = arg_10_0.mapMo and string.format("%s-%s", var_10_0[1], var_10_0[2]) or "???"

	arg_10_0._simagemap:LoadImage(ResUrl.getSp01OdysseySingleBg("map/odyssey_bigmap_pic_" .. arg_10_0.mapId))
	gohelper.setActive(arg_10_0._gotask, arg_10_0.mapMo)
	gohelper.setActive(arg_10_0._goconquer, arg_10_0.mapMo)
	gohelper.setActive(arg_10_0._gomyth, arg_10_0.mapMo)
	gohelper.setActive(arg_10_0._btnenter.gameObject, arg_10_0.mapMo)
	gohelper.setActive(arg_10_0._golock, not arg_10_0.mapMo)

	if arg_10_0.mapMo then
		local var_10_1, var_10_2 = OdysseyDungeonModel.instance:getCurMainElement()

		gohelper.setActive(arg_10_0._gotask, var_10_2 and var_10_2.mapId == arg_10_0.mapId)

		if var_10_2 then
			arg_10_0._txttask.text = var_10_2.taskDesc or ""
		end

		local var_10_3 = OdysseyDungeonModel.instance:getMapFightElementMoList(arg_10_0.mapId, OdysseyEnum.FightType.Conquer)

		gohelper.setActive(arg_10_0._goconquer, #var_10_3 > 0)

		if #var_10_3 > 0 then
			local var_10_4 = var_10_3[1]:getConquestEleData()

			arg_10_0._txtconquer.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_dungeon_mapselectinfo_conquest"), var_10_4.highWave)
		end

		local var_10_5 = OdysseyDungeonModel.instance:getMapFightElementMoList(arg_10_0.mapId, OdysseyEnum.FightType.Myth)

		if #var_10_5 > 0 then
			local var_10_6 = var_10_5[1]:getMythicEleData()

			gohelper.setActive(arg_10_0._gomyth, true)

			arg_10_0._txtmyth.text = var_10_6.evaluation > 0 and luaLang("odyssey_dungeon_mapselectinfo_mythRecord" .. var_10_6.evaluation) or luaLang("odyssey_myth_record_empty")

			gohelper.setActive(arg_10_0._imagemythResult.gameObject, var_10_6.evaluation > 0)

			if var_10_6.evaluation > 0 then
				UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_10_0._imagemythResult, "pingji_x_" .. var_10_6.evaluation)
			end
		else
			gohelper.setActive(arg_10_0._gomyth, false)
		end
	elseif not string.nilorempty(arg_10_0.mapConfig.unlockCondition) then
		TaskDispatcher.cancelTask(arg_10_0.refreshLockDesc, arg_10_0)
		TaskDispatcher.runRepeat(arg_10_0.refreshLockDesc, arg_10_0, 1)
		arg_10_0:refreshLockDesc()
	end
end

function var_0_0.refreshLockDesc(arg_11_0)
	local var_11_0, var_11_1 = OdysseyDungeonModel.instance:checkConditionCanUnlock(arg_11_0.mapConfig.unlockCondition)

	if var_11_0 then
		TaskDispatcher.cancelTask(arg_11_0.refreshLockDesc, arg_11_0)
	elseif var_11_1.type == OdysseyEnum.ConditionType.Time then
		local var_11_2 = var_11_1.remainTimeStamp
		local var_11_3, var_11_4 = TimeUtil.secondToRoughTime3(var_11_2)

		arg_11_0._txtlock.text = GameUtil.getSubPlaceholderLuaLang(luaLang("odyssey_mapselect_lock_time"), {
			var_11_3,
			var_11_4
		})
	else
		TaskDispatcher.cancelTask(arg_11_0.refreshLockDesc, arg_11_0)

		arg_11_0._txtlock.text = arg_11_0.mapConfig.unlockDesc
	end
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.refreshLockDesc, arg_12_0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowDungeonRightUI, true)
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_popup_fold)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagemap:UnLoadImage()
end

return var_0_0
