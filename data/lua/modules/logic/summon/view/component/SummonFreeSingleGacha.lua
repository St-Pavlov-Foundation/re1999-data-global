module("modules.logic.summon.view.component.SummonFreeSingleGacha", package.seeall)

local var_0_0 = class("SummonFreeSingleGacha", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._btnSummonGO = arg_1_1
	arg_1_0._btnSummonGroupGO = nil
	arg_1_0._summonId = arg_1_2
	arg_1_0._canShowFree = SummonConfig.instance:canShowSingleFree(arg_1_0._summonId)

	if not gohelper.isNil(arg_1_0._btnSummonGO) and arg_1_0._canShowFree then
		local var_1_0 = arg_1_0._btnSummonGO.transform.parent

		if not gohelper.isNil(var_1_0) and not gohelper.isNil(var_1_0.parent) then
			arg_1_0._btnSummonGroupGO = var_1_0.gameObject

			local var_1_1 = var_1_0.parent.gameObject

			gohelper.setActive(arg_1_0._btnSummonGroupGO, false)

			arg_1_0._prefabLoader = PrefabInstantiate.Create(var_1_1)

			arg_1_0._prefabLoader:startLoad(ResUrl.getSummonFreeButton(), arg_1_0.handleInstanceLoaded, arg_1_0)
		end
	end
end

function var_0_0.dispose(arg_2_0)
	logNormal("SummonFreeSingleGacha dispose : " .. tostring(arg_2_0._summonId))

	if arg_2_0._prefabLoader then
		arg_2_0._prefabLoader:onDestroy()
	end

	if arg_2_0._btnFreeSummon then
		arg_2_0._btnFreeSummon:RemoveClickListener()
	end

	arg_2_0:__onDispose()
end

function var_0_0.handleInstanceLoaded(arg_3_0)
	if arg_3_0._prefabLoader and arg_3_0._summonId then
		arg_3_0._btnFreeSummonGO = arg_3_0._prefabLoader:getInstGO()

		local var_3_0 = arg_3_0._btnSummonGroupGO.transform:GetSiblingIndex()

		arg_3_0._btnFreeSummonGO.transform:SetSiblingIndex(var_3_0 + 1)
		arg_3_0:initButton()
		arg_3_0:refreshUI()
	end
end

function var_0_0.initButton(arg_4_0)
	if arg_4_0._btnFreeSummonGO then
		local var_4_0, var_4_1 = recthelper.getAnchor(arg_4_0._btnSummonGroupGO.transform)

		recthelper.setAnchor(arg_4_0._btnFreeSummonGO.transform, var_4_0, var_4_1)

		arg_4_0._gobtn = gohelper.findChild(arg_4_0._btnFreeSummonGO, "#go_btn")
		arg_4_0._gobanner = gohelper.findChild(arg_4_0._btnFreeSummonGO, "#go_banner")
		arg_4_0._txtbanner = gohelper.findChildText(arg_4_0._btnFreeSummonGO, "#go_banner/#txt_banner")
		arg_4_0._btnFreeSummon = gohelper.findChildButton(arg_4_0._btnFreeSummonGO, "#go_btn/#btn_summonfree")

		arg_4_0._btnFreeSummon:AddClickListener(arg_4_0.onClickSummon, arg_4_0)
		arg_4_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_4_0.refreshOpenTime, arg_4_0)
	end
end

function var_0_0.onClickSummon(arg_5_0)
	if arg_5_0._summonId then
		logNormal("SummonFreeSingleGacha send summon 1")
		SummonMainController.instance:sendStartSummon(arg_5_0._summonId, 1, false, true)
	end
end

function var_0_0.refreshUI(arg_6_0)
	if arg_6_0._summonId and not gohelper.isNil(arg_6_0._btnFreeSummonGO) and not gohelper.isNil(arg_6_0._btnSummonGroupGO) then
		local var_6_0 = SummonMainModel.instance:getPoolServerMO(arg_6_0._summonId)

		if var_6_0.haveFree then
			arg_6_0._needCountDown = false

			gohelper.setActive(arg_6_0._btnFreeSummonGO, true)
			gohelper.setActive(arg_6_0._btnSummonGroupGO, false)
			gohelper.setActive(arg_6_0._gobtn, true)

			arg_6_0._txtbanner.text = luaLang("summon_timelimit_free")
		else
			gohelper.setActive(arg_6_0._gobtn, false)
			gohelper.setActive(arg_6_0._btnSummonGroupGO, true)

			local var_6_1 = SummonConfig.instance:getSummonPool(arg_6_0._summonId)

			if var_6_1 and var_6_0.usedFreeCount < var_6_1.totalFreeCount then
				arg_6_0._needCountDown = true

				gohelper.setActive(arg_6_0._btnFreeSummonGO, true)
			else
				arg_6_0._needCountDown = false

				gohelper.setActive(arg_6_0._btnFreeSummonGO, false)
			end
		end
	end

	arg_6_0:refreshOpenTime()
end

function var_0_0.refreshOpenTime(arg_7_0)
	if arg_7_0._needCountDown then
		local var_7_0 = ServerTime.getToadyEndTimeStamp(true) - ServerTime.nowInLocal()
		local var_7_1, var_7_2 = TimeUtil.secondToRoughTime2(var_7_0)

		arg_7_0._txtbanner.text = string.format(luaLang("summon_free_after_time"), tostring(var_7_1) .. tostring(var_7_2))
	end
end

return var_0_0
