module("modules.logic.survival.view.map.SurvivalMapTalentView", package.seeall)

local var_0_0 = class("SurvivalMapTalentView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._rootPath = arg_1_1 or ""
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btnTalent = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, arg_2_0._rootPath .. "Left/#btn_effect")
	arg_2_0._goTalentTips = gohelper.findChild(arg_2_0.viewGO, arg_2_0._rootPath .. "Left/#go_effectTips")
	arg_2_0._goTalentTipsItem = gohelper.findChild(arg_2_0.viewGO, arg_2_0._rootPath .. "Left/#go_effectTips/#scroll_tips/viewport/content/#go_effectItem")
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnTalent, arg_3_0._onClickTalent, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnTalentChange, arg_3_0._ontalentChange, arg_3_0)
	arg_3_0.viewContainer:registerCallback(SurvivalEvent.OnClickSurvivalScene, arg_3_0._onSceneClick, arg_3_0)
	arg_3_0.viewContainer:registerCallback(SurvivalEvent.OnClickShelterScene, arg_3_0._onSceneClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeClickCb(arg_4_0._btnTalent)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnTalentChange, arg_4_0._ontalentChange, arg_4_0)
	arg_4_0.viewContainer:unregisterCallback(SurvivalEvent.OnClickSurvivalScene, arg_4_0._onSceneClick, arg_4_0)
	arg_4_0.viewContainer:unregisterCallback(SurvivalEvent.OnClickShelterScene, arg_4_0._onSceneClick, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0._goTalentTips, false)
	arg_5_0:_ontalentChange()
end

function var_0_0._onSceneClick(arg_6_0)
	gohelper.setActive(arg_6_0._goTalentTips, false)
end

function var_0_0._onClickTalent(arg_7_0)
	SurvivalStatHelper.instance:statBtnClick("_onClickTalent", "  SurvivalMapTalentView")

	local var_7_0 = not arg_7_0._goTalentTips.activeSelf

	gohelper.setActive(arg_7_0._goTalentTips, var_7_0)

	if not var_7_0 then
		return
	end

	local var_7_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_1.talents) do
		local var_7_3 = lua_survival_talent.configDict[iter_7_1]

		if not var_7_3 then
			logError("天赋配置不存在：" .. tostring(iter_7_1))
		else
			table.insert(var_7_2, {
				title = var_7_3.name,
				desc = var_7_3.desc1
			})
		end
	end

	gohelper.CreateObjList(arg_7_0, arg_7_0._createDesc, var_7_2, nil, arg_7_0._goTalentTipsItem, nil, nil, nil, 1)
end

function var_0_0._createDesc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildTextMesh(arg_8_1, "#txt_title")
	local var_8_1 = gohelper.findChildTextMesh(arg_8_1, "#txt_dec")

	var_8_0.text = arg_8_2.title
	var_8_1.text = arg_8_2.desc
end

function var_0_0._ontalentChange(arg_9_0)
	local var_9_0 = SurvivalShelterModel.instance:getWeekInfo()

	gohelper.setActive(arg_9_0._btnTalent, #var_9_0.talents > 0)
end

return var_0_0
