module("modules.logic.fight.view.FightSkillTargetView", package.seeall)

local var_0_0 = class("FightSkillTargetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._groupGO = gohelper.findChild(arg_1_0.viewGO, "group")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._itemList = {}
	arg_1_0._targetLimit = nil
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SimulateSelectSkillTargetInView, arg_2_0._simulateSelect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SimulateSelectSkillTargetInView, arg_3_0._simulateSelect, arg_3_0)

	for iter_3_0 = 1, #arg_3_0._itemList do
		local var_3_0 = arg_3_0._itemList[iter_3_0]

		gohelper.getClick(var_3_0.go):RemoveClickListener()
	end
end

function var_0_0.onOpen(arg_4_0)
	PostProcessingMgr.instance:setBlurWeight(1)
	arg_4_0._simagebg:LoadImage(ResUrl.getFightSkillTargetcIcon("full/zhandouxuanzedi_007"))

	arg_4_0._targetLimit = arg_4_0.viewParam.targetLimit

	if arg_4_0.viewParam.desc then
		arg_4_0._txtDesc.text = arg_4_0.viewParam.desc
	else
		arg_4_0._txtDesc.text = luaLang("select_skill_target")
	end

	if not arg_4_0._targetLimit then
		local var_4_0 = arg_4_0.viewParam.skillId

		arg_4_0._targetLimit = {}

		local var_4_1 = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, var_4_0, arg_4_0.viewParam.fromId)

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			local var_4_2 = FightDataHelper.entityMgr:getById(iter_4_1)

			if var_4_2.entityType == 3 then
				-- block empty
			elseif var_4_2:hasBuffFeature(FightEnum.BuffType_CantSelect) or var_4_2:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
				-- block empty
			elseif DungeonModel.instance.curSendChapterId ~= DungeonEnum.ChapterId.RoleDuDuGu or var_4_2.originSkin ~= CharacterEnum.DefaultSkinId.DuDuGu then
				table.insert(arg_4_0._targetLimit, iter_4_1)
			end
		end
	end

	table.sort(arg_4_0._targetLimit, var_0_0._sortByStandPos)

	local var_4_3 = arg_4_0.viewContainer:getSetting().otherRes[1]

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._targetLimit) do
		local var_4_4 = arg_4_0._itemList[iter_4_2]

		if not var_4_4 then
			local var_4_5 = arg_4_0:getResInst(var_4_3, arg_4_0._groupGO, "item" .. iter_4_2)

			var_4_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_5, FightSkillTargetItem)

			table.insert(arg_4_0._itemList, var_4_4)
			gohelper.getClick(var_4_4.go):AddClickListener(arg_4_0._onClickItem, arg_4_0, iter_4_2)
		end

		gohelper.setActive(var_4_4.go, true)
		var_4_4:onUpdateMO(iter_4_3)
	end

	for iter_4_4 = #arg_4_0._targetLimit + 1, #arg_4_0._itemList do
		gohelper.setActive(arg_4_0._itemList[iter_4_4].go, false)
	end

	if arg_4_0.viewParam.mustSelect then
		arg_4_0._mustSelect = true

		NavigateMgr.instance:addEscape(arg_4_0.viewContainer.viewName, arg_4_0._onBtnEsc, arg_4_0)
	end
end

function var_0_0._onBtnEsc(arg_5_0)
	return
end

function var_0_0._sortByStandPos(arg_6_0, arg_6_1)
	local var_6_0 = FightDataHelper.entityMgr:getById(arg_6_0)
	local var_6_1 = FightDataHelper.entityMgr:getById(arg_6_1)

	if var_6_0 and var_6_1 then
		return math.abs(var_6_0.position) < math.abs(var_6_1.position)
	else
		return math.abs(tonumber(arg_6_0)) < math.abs(tonumber(arg_6_1))
	end
end

function var_0_0._onClickItem(arg_7_0, arg_7_1)
	arg_7_0:closeThis()

	local var_7_0 = arg_7_0._targetLimit[arg_7_1]
	local var_7_1 = arg_7_0.viewParam.callback
	local var_7_2 = arg_7_0.viewParam.callbackObj

	if var_7_2 then
		var_7_1(var_7_2, var_7_0)
	else
		var_7_1(var_7_0)
	end
end

function var_0_0.onClose(arg_8_0)
	arg_8_0._simagebg:UnLoadImage()
	PostProcessingMgr.instance:setBlurWeight(0)
end

function var_0_0.onClickModalMask(arg_9_0)
	if arg_9_0._mustSelect then
		return
	end

	arg_9_0:closeThis()
end

function var_0_0._simulateSelect(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._targetLimit) do
		if iter_10_1 == arg_10_1 then
			arg_10_0:_onClickItem(iter_10_0)

			return
		end
	end

	arg_10_0:_onClickItem(1)
	logError("模拟选中entity失败，不存在的entityId = " .. arg_10_1 .. "，只有：" .. cjson.encode(arg_10_0._targetLimit))
end

return var_0_0
