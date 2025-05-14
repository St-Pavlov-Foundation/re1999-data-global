module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverResultView", package.seeall)

local var_0_0 = class("V1a6_CachotRoleRecoverResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotipswindow = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goteamprepareitem = gohelper.findChild(arg_1_0.viewGO, "#go_teamprepareitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_easter_success)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0._initPresetItem(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer:getSetting().otherRes[1]
	local var_7_1 = arg_7_0:getResInst(var_7_0, arg_7_0._goteamprepareitem)

	arg_7_0._item = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, V1a6_CachotRoleRecoverPresetItem)
end

function var_0_0._initPrepareItem(arg_8_0)
	local var_8_0 = arg_8_0.viewContainer:getSetting().otherRes[2]
	local var_8_1 = arg_8_0:getResInst(var_8_0, arg_8_0._goteamprepareitem)

	arg_8_0._item = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, V1a6_CachotRoleRecoverPrepareItem)
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._mo = arg_9_0.viewParam[1]

	if V1a6_CachotTeamModel.instance:getSeatInfo(arg_9_0._mo) then
		arg_9_0:_initPresetItem()
	else
		arg_9_0:_initPrepareItem()
	end

	arg_9_0._item:onUpdateMO(arg_9_0._mo)
	arg_9_0:_tweenHp()
end

function var_0_0._tweenHp(arg_10_0)
	local var_10_0 = V1a6_CachotModel.instance:getChangeLifes()

	if not var_10_0 then
		return
	end

	local var_10_1 = arg_10_0._item:getHeroMo()

	if not var_10_1 then
		return
	end

	local var_10_2 = V1a6_CachotModel.instance:getTeamInfo()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if var_10_1.heroId == iter_10_1.heroId then
			local var_10_3 = var_10_2:getHeroHp(iter_10_1.heroId)

			arg_10_0._item:tweenHp(iter_10_1.life, var_10_3.life, 0.3)

			break
		end
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
