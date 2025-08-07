module("modules.logic.sp01.odyssey.view.OdysseySuitListItem", package.seeall)

local var_0_0 = class("OdysseySuitListItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._goUnEffect = gohelper.findChild(arg_1_0.viewGO, "uneffect")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "uneffect/#image_icon")
	arg_1_0._txtSuitName = gohelper.findChildText(arg_1_0.viewGO, "uneffect/#txt_SuitName")
	arg_1_0._txtLevel = gohelper.findChildText(arg_1_0.viewGO, "uneffect/#txt_Level")
	arg_1_0._goEffect = gohelper.findChild(arg_1_0.viewGO, "effect")
	arg_1_0._imageiconEffect = gohelper.findChildImage(arg_1_0.viewGO, "effect/#image_icon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "effect/Num/#txt_num")
	arg_1_0._txtSuitNameEffect = gohelper.findChildText(arg_1_0.viewGO, "effect/#txt_SuitName")
	arg_1_0._txtLevelEffect = gohelper.findChildText(arg_1_0.viewGO, "effect/#txt_Level")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	local var_4_0 = {
		suitId = arg_4_0.id,
		bagType = OdysseyEnum.BagType.FightPrepare,
		pos = recthelper.uiPosToScreenPos(arg_4_0.viewGO.transform)
	}

	OdysseyController.instance:openSuitTipsView(var_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._effectFlashGO = gohelper.findChild(arg_5_0.viewGO, "effect/BG/vx_flash")
	arg_5_0.curEffectState = nil
	arg_5_0.curSuitLevel = 0
end

function var_0_0.setInfo(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = OdysseyHeroGroupModel.instance:getCurHeroGroup()
	local var_7_1 = arg_7_0.id
	local var_7_2 = OdysseyConfig.instance:getEquipSuitConfig(var_7_1)
	local var_7_3 = var_7_0:getOdysseyEquipSuit(var_7_1)
	local var_7_4 = OdysseyConfig.instance:getEquipSuitAllEffect(var_7_1)
	local var_7_5 = #var_7_4
	local var_7_6 = {}
	local var_7_7 = false

	if var_7_3 ~= nil then
		for iter_7_0 = 1, var_7_5 do
			local var_7_8 = var_7_4[iter_7_0]

			if var_7_3 and var_7_3.count >= var_7_8.number then
				var_7_7 = true

				break
			end
		end
	end

	if (arg_7_0.curSuitLevel < var_7_3.level and arg_7_0.curSuitLevel > 0 or arg_7_0.curEffectState == false) and var_7_7 then
		gohelper.setActive(arg_7_0._effectFlashGO, false)
		gohelper.setActive(arg_7_0._effectFlashGO, true)
	end

	arg_7_0.curSuitLevel = var_7_3.level
	arg_7_0.curEffectState = var_7_7

	gohelper.setActive(arg_7_0._goEffect, var_7_7)
	gohelper.setActive(arg_7_0._goUnEffect, not var_7_7)

	local var_7_9 = not var_7_7 and arg_7_0._txtSuitName or arg_7_0._txtSuitNameEffect
	local var_7_10 = not var_7_7 and arg_7_0._txtLevel or arg_7_0._txtLevelEffect
	local var_7_11 = not var_7_7 and arg_7_0._imageicon or arg_7_0._imageiconEffect
	local var_7_12 = not var_7_7 and "" or "<color=#ECDFBD>%s"
	local var_7_13 = not var_7_7 and "" or "%s</color>"
	local var_7_14 = false

	for iter_7_1 = 1, var_7_5 do
		local var_7_15 = var_7_4[iter_7_1]

		table.insert(var_7_6, tostring(var_7_15.number))

		if var_7_7 and var_7_3.level <= var_7_15.level and var_7_14 == false then
			var_7_14 = true
			var_7_6[iter_7_1] = string.format(var_7_13, var_7_6[iter_7_1])
		end
	end

	if var_7_7 then
		var_7_6[1] = string.format(var_7_12, var_7_6[1])
	end

	var_7_10.text = table.concat(var_7_6, "/")
	var_7_9.text = var_7_2.name

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(var_7_11, var_7_2.icon)

	arg_7_0._txtnum.text = tostring(var_7_3.count)
end

function var_0_0.setActive(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0.viewGO, arg_8_1)
end

function var_0_0.onDestroy(arg_9_0)
	return
end

return var_0_0
