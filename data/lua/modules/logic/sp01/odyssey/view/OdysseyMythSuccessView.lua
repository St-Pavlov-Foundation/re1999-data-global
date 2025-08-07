module("modules.logic.sp01.odyssey.view.OdysseyMythSuccessView", package.seeall)

local var_0_0 = class("OdysseyMythSuccessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gotargets = gohelper.findChild(arg_1_0.viewGO, "#go_targets")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "#go_targets/#go_targetitem")
	arg_1_0._recordList = arg_1_0:getUserDataTb_()

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
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._resultMo = OdysseyModel.instance:getFightResultInfo()

	arg_7_0:_initTargetItem()
end

function var_0_0._initTargetItem(arg_8_0)
	arg_8_0._elementId = arg_8_0._resultMo:getElementId()
	arg_8_0._elementCo = OdysseyConfig.instance:getElementFightConfig(arg_8_0._elementId)

	local var_8_0 = GameUtil.splitString2(arg_8_0._elementCo.param, true)
	local var_8_1 = arg_8_0._resultMo:getFightFinishedTaskIdList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_2 = arg_8_0._recordList[iter_8_0]

		if not var_8_2 then
			var_8_2 = {
				go = gohelper.clone(arg_8_0._gotargetitem, arg_8_0._gotargets, "target" .. iter_8_0)
			}
			var_8_2.gofinish = gohelper.findChild(var_8_2.go, "go_finish")
			var_8_2.txtfinishdesc = gohelper.findChildText(var_8_2.go, "go_finish/#txt_taskdesc")
			var_8_2.imagefinishicon = gohelper.findChildImage(var_8_2.go, "go_finish/#image_icon")
			var_8_2.gounfinish = gohelper.findChild(var_8_2.go, "go_unfinish")
			var_8_2.txtunfinishdesc = gohelper.findChildText(var_8_2.go, "go_unfinish/#txt_taskdesc")
			var_8_2.imageunfinishicon = gohelper.findChildImage(var_8_2.go, "go_unfinish/#image_icon")
			var_8_2.animtor = var_8_2.go:GetComponent(gohelper.Type_Animator)

			table.insert(arg_8_0._recordList, var_8_2)
		end

		gohelper.setActive(var_8_2.go, true)

		local var_8_3 = iter_8_1[1]
		local var_8_4 = iter_8_1[2]
		local var_8_5 = tabletool.indexOf(var_8_1, var_8_4)
		local var_8_6 = OdysseyConfig.instance:getFightTaskDescConfig(var_8_4)

		var_8_2.txtfinishdesc.text = var_8_6.desc
		var_8_2.txtunfinishdesc.text = var_8_6.desc

		local var_8_7 = "pingji_x_" .. var_8_3

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(var_8_2.imagefinishicon, var_8_7)
		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(var_8_2.imageunfinishicon, var_8_7)
		gohelper.setActive(var_8_2.gofinish, var_8_5)
		gohelper.setActive(var_8_2.gounfinish, not var_8_5)

		if var_8_5 then
			var_8_2.animtor:Update(0)
			var_8_2.animtor:Play("open", 0, 0)
		end
	end
end

function var_0_0.onClose(arg_9_0)
	OdysseyRpc.instance:sendOdysseyGetInfoRequest(function()
		ViewMgr.instance:openView(ViewName.OdysseyMythResultView)
	end, arg_9_0)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
