module("modules.logic.survival.view.map.SurvivalMapSelectView", package.seeall)

local var_0_0 = class("SurvivalMapSelectView", SurvivalInitTeamView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0._root, "Right/#btn_next")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0._root, "Right/txt_title")
	arg_1_0._imagePic = gohelper.findChildSingleImage(arg_1_0._root, "Right/simage_pic")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0._root, "Right/scroll_desc/Viewport/#go_descContent/#txt_desc")
	arg_1_0._goeffectdesc = gohelper.findChild(arg_1_0._root, "Right/scroll_desc/Viewport/#go_descContent/go_descitem")
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
	local var_4_1 = var_4_0.clientData.data.nowUnlockMaps
	local var_4_2 = false

	arg_4_0._items = {}

	for iter_4_0 = 1, 6 do
		local var_4_3 = gohelper.findChild(arg_4_0._root, "Map/#go_map" .. iter_4_0)

		arg_4_0._items[iter_4_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_3, SurvivalMapSelectItem, {
			callback = arg_4_0.onClickMap,
			callobj = arg_4_0,
			index = iter_4_0
		})

		if var_4_0.copyIds[iter_4_0] and not tabletool.indexOf(var_4_1, iter_4_0) then
			table.insert(var_4_1, iter_4_0)

			var_4_2 = true

			arg_4_0._items[iter_4_0]:playUnlockAnim()
		end
	end

	if var_4_2 then
		var_4_0.clientData:saveDataToServer()
		UIBlockHelper.instance:startBlock("SurvivalMapSelectView_unlock", 1)
	end

	arg_4_0:onClickMap(arg_4_0._groupMo.selectCopyIndex, true)
end

function var_0_0.onClickMap(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_2 and arg_5_0._groupMo.selectCopyIndex == arg_5_1 then
		return
	end

	if not arg_5_2 then
		arg_5_0.viewContainer:playAnim("right_out")
		TaskDispatcher.runDelay(arg_5_0._delayPlayIn, arg_5_0, 0.1)
		UIBlockHelper.instance:startBlock("SurvivalMapSelectView_switch", 0.1)
	else
		arg_5_0:_refreshInfo()
	end

	arg_5_0._groupMo.selectCopyIndex = arg_5_1

	for iter_5_0 = 1, 6 do
		arg_5_0._items[iter_5_0]:setIsSelect(iter_5_0 == arg_5_1)
	end

	if not arg_5_2 then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.SurvivalMapSelect, tostring(arg_5_1))
	end
end

function var_0_0._delayPlayIn(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_switch)
	arg_6_0.viewContainer:playAnim("right_in")
	arg_6_0:_refreshInfo()
end

function var_0_0._refreshInfo(arg_7_0)
	local var_7_0 = lua_survival_copy.configDict[arg_7_0._groupMo.selectCopyIndex]

	if not var_7_0 then
		return
	end

	arg_7_0._imagePic:LoadImage(ResUrl.getSurvivalMapIcon(var_7_0.pic))

	arg_7_0._txttitle.text = var_7_0.name
	arg_7_0._txtdesc.text = var_7_0.desc

	local var_7_1 = string.split(var_7_0.effectDesc, "|") or {}

	gohelper.CreateObjList(arg_7_0, arg_7_0._createEffectDesc, var_7_1, nil, arg_7_0._goeffectdesc, nil, nil, nil, 1)
end

function var_0_0._createEffectDesc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	gohelper.findChildTextMesh(arg_8_1, "#txt_desc").text = arg_8_2
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
