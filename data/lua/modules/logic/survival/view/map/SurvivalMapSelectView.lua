module("modules.logic.survival.view.map.SurvivalMapSelectView", package.seeall)

local var_0_0 = class("SurvivalMapSelectView", SurvivalInitTeamView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0._root, "Right/#btn_next")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0._root, "Right/txt_title")
	arg_1_0._imagePic = gohelper.findChildSingleImage(arg_1_0._root, "Right/simage_pic")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0._root, "Right/scroll_desc/Viewport/#go_descContent/#txt_desc")
	arg_1_0._goeffectdesc = gohelper.findChild(arg_1_0._root, "Right/scroll_desc/Viewport/#go_descContent/go_descitem/#txt_desc")
	arg_1_0._goeasy = gohelper.findChild(arg_1_0._root, "Right/#go_difficulty/easy")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0._root, "Right/#go_difficulty/normal")
	arg_1_0._gohard = gohelper.findChild(arg_1_0._root, "Right/#go_difficulty/hard")
	arg_1_0._gohardEffect = gohelper.findChild(arg_1_0.viewGO, "#simage_bghard")
	arg_1_0.BossInvasionContainer = gohelper.findChild(arg_1_0._root, "Map/BossInvasionContainer")

	local var_1_0 = arg_1_0.viewContainer:getSetting().otherRes.survivalbossinvasionview
	local var_1_1 = arg_1_0:getResInst(var_1_0, arg_1_0.BossInvasionContainer)

	arg_1_0.survivalBossInvasionView = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_1, SurvivalBossInvasionView, 2)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0.onClickNext, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._groupMo = SurvivalMapModel.instance:getInitGroup()

	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo()

	arg_4_0._items = {}

	local var_4_1 = var_4_0.clientData.data.nowUnlockMapsCount
	local var_4_2 = false

	for iter_4_0 = 1, 4 do
		local var_4_3 = var_4_0.mapInfos[iter_4_0]
		local var_4_4 = gohelper.findChild(arg_4_0._root, "Map/#go_map" .. iter_4_0)

		arg_4_0._items[iter_4_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_4, SurvivalMapSelectItem, {
			callback = arg_4_0.onClickMap,
			callobj = arg_4_0,
			mapInfo = var_4_3,
			index = iter_4_0
		})

		if var_4_3 and var_4_1 < iter_4_0 then
			arg_4_0._items[iter_4_0]:playUnlockAnim()

			var_4_2 = true
		end
	end

	if var_4_2 then
		var_4_0.clientData.data.nowUnlockMapsCount = #var_4_0.mapInfos

		var_4_0.clientData:saveDataToServer(true)
	end

	arg_4_0:onClickMap(arg_4_0._groupMo.selectMapIndex + 1, true)
end

function var_0_0.onClickMap(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_2 and arg_5_0._groupMo.selectMapIndex == arg_5_1 - 1 then
		return
	end

	if not arg_5_2 then
		arg_5_0.viewContainer:playAnim("right_out")
		TaskDispatcher.runDelay(arg_5_0._delayPlayIn, arg_5_0, 0.1)
		UIBlockHelper.instance:startBlock("SurvivalMapSelectView_switch", 0.1)
	else
		arg_5_0:_refreshInfo()
	end

	arg_5_0._groupMo.selectMapIndex = arg_5_1 - 1

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._items) do
		iter_5_1:setIsSelect(iter_5_0 == arg_5_1)
	end
end

function var_0_0._delayPlayIn(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_switch)
	arg_6_0.viewContainer:playAnim("right_in")
	arg_6_0:_refreshInfo()
end

function var_0_0._refreshInfo(arg_7_0)
	local var_7_0 = SurvivalShelterModel.instance:getWeekInfo().mapInfos[arg_7_0._groupMo.selectMapIndex + 1]
	local var_7_1 = var_7_0.groupCo

	if not var_7_1 then
		logError("没有地图组配置" .. var_7_0.mapId)

		return
	end

	arg_7_0._imagePic:LoadImage(ResUrl.getSurvivalMapIcon("survival_map_pic0" .. var_7_1.type))

	arg_7_0._txttitle.text = var_7_1.name
	arg_7_0._txtdesc.text = var_7_0.taskCo and var_7_0.taskCo.desc2 or ""

	local var_7_2 = string.split(var_7_1.effectDesc, "|") or {}

	if var_7_0.disasterCo then
		table.insert(var_7_2, 1, var_7_0.disasterCo.disasterDesc)
	elseif var_7_0.disasterId == 0 then
		local var_7_3, var_7_4 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.NoDisasterDesc)

		if not string.nilorempty(var_7_4) then
			table.insert(var_7_2, 1, var_7_4)
		end
	end

	if var_7_0.rainCo then
		table.insert(var_7_2, 1, var_7_0.rainCo.rainDesc)
	end

	gohelper.setActive(arg_7_0._goeasy, var_7_0.level == 1)
	gohelper.setActive(arg_7_0._gonormal, var_7_0.level == 2)
	gohelper.setActive(arg_7_0._gohard, var_7_0.level == 3)
	gohelper.setActive(arg_7_0._gohardEffect, var_7_0.level == 3)
	gohelper.CreateObjList(arg_7_0, arg_7_0._createEffectDesc, var_7_2, nil, arg_7_0._goeffectdesc)
end

function var_0_0._createEffectDesc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	gohelper.findChildTextMesh(arg_8_1, "").text = arg_8_2
end

function var_0_0.onClickNext(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayPlayIn, arg_9_0)
	arg_9_0.viewContainer:playAnim("go_selectmember")
	arg_9_0.viewContainer:nextStep()
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayPlayIn, arg_10_0)
	var_0_0.super.onClose(arg_10_0)
end

return var_0_0
