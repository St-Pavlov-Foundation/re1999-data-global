module("modules.logic.seasonver.act166.view.Season166WordEffectView", package.seeall)

local var_0_0 = class("Season166WordEffectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.content = gohelper.findChild(arg_1_0.viewGO, "#go_wordEffectContent")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0.wordContentGO = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[1], arg_2_0.content)
	arg_2_0.wordEffect = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[2], arg_2_0.wordContentGO)
	arg_2_0.viewType = arg_2_0.viewParam.viewType
	arg_2_0.actId = arg_2_0.viewParam.actId

	gohelper.setActive(arg_2_0.wordContentGO, false)
	gohelper.setActive(arg_2_0.wordEffect, false)

	arg_2_0.wordEffectConfigList = Season166Config.instance:getSeasonWordEffectConfigList(arg_2_0.viewParam.actId, arg_2_0.viewType)

	TaskDispatcher.runRepeat(arg_2_0._createWord, arg_2_0, Season166Enum.WordInterval, -1)
	arg_2_0:_createWord()
end

function var_0_0._createWord(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_aekn_piaozi)

	if not arg_3_0._nowPosIndex then
		arg_3_0._nowPosIndex = math.random(1, #arg_3_0.wordEffectConfigList)
	else
		local var_3_0 = math.random(1, #arg_3_0.wordEffectConfigList - 1)

		if var_3_0 >= arg_3_0._nowPosIndex then
			var_3_0 = var_3_0 + 1
		end

		arg_3_0._nowPosIndex = var_3_0
	end

	arg_3_0._coIndexSort = arg_3_0._coIndexSort or {}

	if arg_3_0._coIndexSort[1] then
		arg_3_0._nowCoIndex = table.remove(arg_3_0._coIndexSort, 1)
	else
		for iter_3_0 = 1, #arg_3_0.wordEffectConfigList do
			arg_3_0._coIndexSort[iter_3_0] = iter_3_0
		end

		arg_3_0._coIndexSort = GameUtil.randomTable(arg_3_0._coIndexSort)

		if arg_3_0._nowCoIndex == arg_3_0._coIndexSort[1] then
			arg_3_0._nowCoIndex = table.remove(arg_3_0._coIndexSort, 2)
		else
			arg_3_0._nowCoIndex = table.remove(arg_3_0._coIndexSort, 1)
		end
	end

	local var_3_1 = gohelper.cloneInPlace(arg_3_0.wordContentGO)

	gohelper.setActive(var_3_1, true)

	local var_3_2 = arg_3_0.wordEffectConfigList[arg_3_0._nowCoIndex]
	local var_3_3 = Season166Config.instance:getSeasonWordEffectPosConfig(arg_3_0.actId, var_3_2.id)
	local var_3_4 = string.splitToNumber(var_3_3.pos, "#")

	recthelper.setAnchor(var_3_1.transform, var_3_4[1], var_3_4[2])
	MonoHelper.addNoUpdateLuaComOnceToGo(var_3_1, Season166WordEffectComp, {
		co = var_3_2,
		res = arg_3_0.wordEffect
	})
end

function var_0_0.onClose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._createWord, arg_4_0)
end

return var_0_0
