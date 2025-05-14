module("modules.logic.fight.view.FightNaNaTargetView", package.seeall)

local var_0_0 = class("FightNaNaTargetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goUnSelected = gohelper.findChild(arg_1_0.viewGO, "#go_UnSelected")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0._goItemGroup = gohelper.findChild(arg_1_0.viewGO, "#go_itemgroup")
	arg_1_0._txtSkillName = gohelper.findChildText(arg_1_0.viewGO, "#go_Selected/#txt_SkillName")
	arg_1_0._txtSkillDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_Selected/#txt_SkillDescr")
	arg_1_0._btnSign = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Sign")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSign:AddClickListener(arg_2_0._btnSignOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSign:RemoveClickListener()
end

function var_0_0._btnSignOnClick(arg_4_0)
	if arg_4_0.curSelectEntity == 0 then
		return
	end

	AudioMgr.instance:trigger(20220174)
	FightRpc.instance:sendUseClothSkillRequest(0, arg_4_0.nanaEntityId, arg_4_0.curSelectEntity, FightEnum.ClothSkillType.Contract)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.goBtnSign = arg_5_0._btnSign.gameObject

	gohelper.setActive(arg_5_0.goBtnSign, false)

	local var_5_0 = arg_5_0.viewContainer:getSetting().otherRes[1]

	arg_5_0.itemPrefab = arg_5_0.viewContainer:getRes(var_5_0)
	arg_5_0.itemList = {}

	arg_5_0:initCareerBindBuff()
	NavigateMgr.instance:addEscape(arg_5_0.viewName, arg_5_0.blockEsc)
	arg_5_0:addEventCb(FightController.instance, FightEvent.StartPlayClothSkill, arg_5_0.onStartPlayClothSkill, arg_5_0, LuaEventSystem.High)
	arg_5_0:addEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, arg_5_0.closeThis, arg_5_0, LuaEventSystem.High)
end

function var_0_0.blockEsc()
	return
end

function var_0_0.onStartPlayClothSkill(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(20220172)

	arg_8_0.curSelectEntity = 0
	arg_8_0.entityIdList = FightModel.instance.canContractList
	arg_8_0.nanaEntityId = FightModel.instance.notifyEntityId

	local var_8_0 = FightDataHelper.entityMgr:getById(arg_8_0.nanaEntityId)

	arg_8_0.nanaExSkillLv = var_8_0 and var_8_0.exSkillLevel or 0

	table.sort(arg_8_0.entityIdList, var_0_0.sortEntityId)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.entityIdList) do
		arg_8_0:addItem(iter_8_1)
	end

	arg_8_0:refreshSelect()
	FightModel.instance:setNotifyContractInfo(nil, nil)
end

function var_0_0.sortEntityId(arg_9_0, arg_9_1)
	local var_9_0 = FightDataHelper.entityMgr:getById(arg_9_0)

	if not var_9_0 then
		return false
	end

	local var_9_1 = FightDataHelper.entityMgr:getById(arg_9_1)

	if not var_9_1 then
		return false
	end

	return var_9_0.position < var_9_1.position
end

function var_0_0.initCareerBindBuff(arg_10_0)
	local var_10_0 = lua_fight_const.configDict[31].value
	local var_10_1 = FightStrUtil.instance:getSplitCache(var_10_0, "|")

	arg_10_0.careerDict = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = string.split(iter_10_1, "%")
		local var_10_3 = tonumber(var_10_2[1])

		for iter_10_2, iter_10_3 in ipairs(string.split(var_10_2[2], ",")) do
			local var_10_4 = string.splitToNumber(iter_10_3, ":")
			local var_10_5 = var_10_4[1]
			local var_10_6 = var_10_4[2]
			local var_10_7 = arg_10_0.careerDict[var_10_5]

			if not var_10_7 then
				var_10_7 = {}
				arg_10_0.careerDict[var_10_5] = var_10_7
			end

			var_10_7[var_10_3] = var_10_6
		end
	end
end

function var_0_0.addItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.go = gohelper.clone(arg_11_0.itemPrefab, arg_11_0._goItemGroup)
	var_11_0.goSelect = gohelper.findChild(var_11_0.go, "#go_SelectedFrame")
	var_11_0.simageIcon = gohelper.findChildSingleImage(var_11_0.go, "icon")
	var_11_0.imageCareer = gohelper.findChildImage(var_11_0.go, "#image_Attr")

	local var_11_1 = FightDataHelper.entityMgr:getById(arg_11_1)

	if var_11_1 then
		local var_11_2 = FightConfig.instance:getSkinCO(var_11_1.skin)

		var_11_0.simageIcon:LoadImage(ResUrl.getHeadIconSmall(var_11_2 and var_11_2.retangleIcon))
	end

	local var_11_3 = var_11_1.career

	UISpriteSetMgr.instance:setCommonSprite(var_11_0.imageCareer, "lssx_" .. var_11_3)

	var_11_0.uid = arg_11_1
	var_11_0.click = gohelper.getClickWithDefaultAudio(var_11_0.go)

	var_11_0.click:AddClickListener(arg_11_0.onClickItem, arg_11_0, arg_11_1)
	table.insert(arg_11_0.itemList, var_11_0)
end

function var_0_0.onClickItem(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0.curSelectEntity then
		return
	end

	AudioMgr.instance:trigger(20220173)

	arg_12_0.curSelectEntity = arg_12_1

	arg_12_0:refreshSelect()
end

function var_0_0.refreshSelect(arg_13_0)
	gohelper.setActive(arg_13_0.goBtnSign, arg_13_0.curSelectEntity ~= 0)
	arg_13_0:refreshSelectStatus()
	arg_13_0:refreshSelectText()
end

function var_0_0.refreshSelectStatus(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.itemList) do
		local var_14_0 = iter_14_1.uid == arg_14_0.curSelectEntity

		gohelper.setActive(iter_14_1.goSelect, var_14_0)
	end
end

function var_0_0.refreshSelectText(arg_15_0)
	local var_15_0 = arg_15_0.curSelectEntity ~= 0

	gohelper.setActive(arg_15_0._goSelected, var_15_0)
	gohelper.setActive(arg_15_0._goUnSelected, not var_15_0)

	if var_15_0 then
		arg_15_0:refreshBuffText()
	end
end

function var_0_0.refreshBuffText(arg_16_0)
	local var_16_0 = FightDataHelper.entityMgr:getById(arg_16_0.curSelectEntity)

	if not var_16_0 then
		logError("没找到entityMo : " .. tostring(arg_16_0.curSelectEntity))

		return
	end

	local var_16_1 = arg_16_0.careerDict[arg_16_0.nanaExSkillLv] or arg_16_0.careerDict[0]
	local var_16_2 = var_16_0.career
	local var_16_3 = var_16_2 and var_16_1[var_16_2]
	local var_16_4 = var_16_3 and lua_skill_buff.configDict[var_16_3]

	if not var_16_4 then
		logError("没找到buffCo : " .. tostring(var_16_3))

		return
	end

	arg_16_0._txtSkillName.text = var_16_4.name
	arg_16_0._txtSkillDescr.text = var_16_4.desc
end

function var_0_0.onClose(arg_17_0)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.BindContract)
end

function var_0_0.onDestroyView(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.itemList) do
		iter_18_1.simageIcon:UnLoadImage()
		iter_18_1.click:RemoveClickListener()
	end

	arg_18_0.itemList = nil
end

return var_0_0
