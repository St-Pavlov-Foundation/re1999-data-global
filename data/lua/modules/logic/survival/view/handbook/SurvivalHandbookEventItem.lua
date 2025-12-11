module("modules.logic.survival.view.handbook.SurvivalHandbookEventItem", package.seeall)

local var_0_0 = class("SurvivalHandbookEventItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.animGo = gohelper.findComponentAnim(arg_1_1)
	arg_1_0.empty = gohelper.findChild(arg_1_1, "#empty")
	arg_1_0.normal = gohelper.findChild(arg_1_1, "#normal")
	arg_1_0.txt_Title = gohelper.findChildTextMesh(arg_1_1, "#normal/Title/#txt_Title")
	arg_1_0.image_model_obj = gohelper.findChild(arg_1_1, "#normal/#image_model")
	arg_1_0.image_model = arg_1_0.image_model_obj:GetComponent(gohelper.Type_RawImage)
	arg_1_0.txt_Descr = gohelper.findChildTextMesh(arg_1_1, "#normal/scroll_overseas/viewport_overseas/#txt_Descr")
	arg_1_0.btnLeftArrow = gohelper.findChildButtonWithAudio(arg_1_1, "#normal/#btnLeftArrow")
	arg_1_0.btnRightArrow = gohelper.findChildButtonWithAudio(arg_1_1, "#normal/#btnRightArrow")
	arg_1_0.txt_Num = gohelper.findChildTextMesh(arg_1_1, "#normal/#txt_Num")
	arg_1_0.refreshFlow = FlowSequence.New()

	arg_1_0.refreshFlow:addWork(TimerWork.New(0.167))
	arg_1_0.refreshFlow:addWork(FunctionWork.New(arg_1_0.refreshDesc, arg_1_0))
end

function var_0_0.getItemAnimators(arg_2_0)
	return {
		arg_2_0.animGo
	}
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.curSelectIndex = 1
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnLeftArrow, arg_4_0.onClickLeft, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnRightArrow, arg_4_0.onClickRight, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0:removeClickCb(arg_5_0.btnLeftArrow)
	arg_5_0:removeClickCb(arg_5_0.btnRightArrow)
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0.refreshFlow:clearWork()
end

function var_0_0.setSurvivalHandbookEventComp(arg_7_0, arg_7_1)
	arg_7_0.survivalHandBookEventComp = arg_7_1
end

function var_0_0.updateMo(arg_8_0, arg_8_1)
	arg_8_0.mo = arg_8_1

	if not arg_8_0.mo.isUnlock then
		gohelper.setActive(arg_8_0.empty, true)
		gohelper.setActive(arg_8_0.normal, false)

		return
	end

	gohelper.setActive(arg_8_0.empty, false)
	gohelper.setActive(arg_8_0.normal, true)

	arg_8_0.txt_Title.text = arg_8_1:getName()

	if not arg_8_0.survivalUI3DRender then
		local var_8_0 = recthelper.getWidth(arg_8_0.image_model.transform)
		local var_8_1 = recthelper.getHeight(arg_8_0.image_model.transform)

		arg_8_0.survivalUI3DRender = arg_8_0.survivalHandBookEventComp:popSurvivalUI3DRender(var_8_0, var_8_1)
		arg_8_0.image_model.texture = arg_8_0.survivalUI3DRender:getRenderTexture()
	end

	if not arg_8_0.survival3DModelMO then
		arg_8_0.survival3DModelMO = Survival3DModelMO.New()
	end

	local var_8_2 = arg_8_0.mo:getEventShowId()

	arg_8_0.survival3DModelMO:setDataByEventID(var_8_2)
	arg_8_0.survivalUI3DRender:setSurvival3DModelMO(arg_8_0.survival3DModelMO)

	local var_8_3 = arg_8_1:getDesc()

	arg_8_0.descIndex = 1
	arg_8_0.textMeshProW = recthelper.getWidth(arg_8_0.txt_Descr.rectTransform)
	arg_8_0.textMeshProH = recthelper.getHeight(arg_8_0.txt_Descr.rectTransform)
	arg_8_0.descList = {}

	if SettingsModel.instance:isOverseas() then
		arg_8_0.descList[1] = var_8_3
	else
		local var_8_4 = var_8_3
		local var_8_5 = 0
		local var_8_6 = GameUtil.utf8len(var_8_4)

		for iter_8_0 = 1, var_8_6 - 1 do
			var_8_5 = var_8_5 + 1

			local var_8_7 = GameUtil.utf8sub(var_8_4, 1, var_8_5)
			local var_8_8 = arg_8_0.txt_Descr:GetPreferredValues(var_8_7, arg_8_0.textMeshProW, arg_8_0.textMeshProH)
			local var_8_9 = var_8_8.x

			if var_8_8.y > arg_8_0.textMeshProH then
				local var_8_10 = GameUtil.utf8sub(var_8_4, 1, var_8_5 - 1)

				table.insert(arg_8_0.descList, var_8_10)

				var_8_4 = GameUtil.utf8sub(var_8_4, var_8_5, var_8_6 - var_8_5 + 1)
				var_8_5 = 1
			elseif iter_8_0 == var_8_6 - 1 then
				local var_8_11 = GameUtil.utf8sub(var_8_4, 1, var_8_5 + 1)

				table.insert(arg_8_0.descList, var_8_11)
			end
		end
	end

	arg_8_0:refreshDesc()
end

function var_0_0.onDisable(arg_9_0)
	if arg_9_0.survivalUI3DRender then
		arg_9_0.survivalHandBookEventComp:pushSurvivalUI3DRender(arg_9_0.survivalUI3DRender)

		arg_9_0.survivalUI3DRender = nil
	end
end

function var_0_0.onDestroy(arg_10_0)
	if arg_10_0.survivalUI3DRender then
		UI3DRenderController.instance.removeSurvivalUI3DRender(arg_10_0.survivalUI3DRender)

		arg_10_0.survivalUI3DRender = nil
	end
end

function var_0_0.onClickLeft(arg_11_0)
	if arg_11_0.descIndex > 1 then
		arg_11_0.descIndex = arg_11_0.descIndex - 1
	end

	arg_11_0.animGo:Play(UIAnimationName.Switch, 0, 0)
	arg_11_0.refreshFlow:clearWork()
	arg_11_0.refreshFlow:start()
end

function var_0_0.onClickRight(arg_12_0)
	if arg_12_0.descIndex < #arg_12_0.descList then
		arg_12_0.descIndex = arg_12_0.descIndex + 1
	end

	arg_12_0.animGo:Play(UIAnimationName.Switch, 0, 0)
	arg_12_0.refreshFlow:clearWork()
	arg_12_0.refreshFlow:start()
end

function var_0_0.refreshBtnArrow(arg_13_0)
	if arg_13_0.descIndex <= 1 then
		gohelper.setActive(arg_13_0.btnLeftArrow, false)
	else
		gohelper.setActive(arg_13_0.btnLeftArrow, true)
	end

	if arg_13_0.descIndex >= #arg_13_0.descList then
		gohelper.setActive(arg_13_0.btnRightArrow, false)
	else
		gohelper.setActive(arg_13_0.btnRightArrow, true)
	end

	if #arg_13_0.descList > 1 then
		gohelper.setActive(arg_13_0.txt_Num.gameObject, true)

		arg_13_0.txt_Num.text = string.format("%s/%s", arg_13_0.descIndex, #arg_13_0.descList)
	else
		gohelper.setActive(arg_13_0.txt_Num.gameObject, false)
	end
end

function var_0_0.refreshDesc(arg_14_0)
	arg_14_0:refreshBtnArrow()

	arg_14_0.txt_Descr.text = arg_14_0.descList[arg_14_0.descIndex]
end

return var_0_0
