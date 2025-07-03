module("modules.logic.fight.view.FightEditorStateLastRoundLogView", package.seeall)

local var_0_0 = class("FightEditorStateLastRoundLogView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnListRoot = gohelper.findChild(arg_1_0.viewGO, "btnScrill/Viewport/Content")
	arg_1_0._btnModel = gohelper.findChild(arg_1_0._btnListRoot, "btnModel")
	arg_1_0._logText = gohelper.findChildText(arg_1_0.viewGO, "ScrollView/Viewport/Content/logText")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = {
		{
			name = "复制"
		}
	}

	arg_6_0:com_createObjList(arg_6_0._onBtnItemShow, var_6_0, arg_6_0._btnListRoot, arg_6_0._btnModel)

	local var_6_1 = FightDataHelper.protoCacheMgr:getLastRoundProto()

	if not var_6_1 then
		arg_6_0._logText.text = "没有数据"

		return
	end

	arg_6_0._strList = {}

	local var_6_2 = FightDataHelper.protoCacheMgr:getLastRoundNum()

	if var_6_2 then
		arg_6_0:addLog("回合" .. var_6_2)
	end

	arg_6_0:addLog(tostring(var_6_1))

	local var_6_3 = table.concat(arg_6_0._strList, "\n")

	arg_6_0._logText.text = FightEditorStateLogView.processStr(var_6_3)
end

function var_0_0._onBtnItemShow(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	gohelper.findChildText(arg_7_1, "text").text = arg_7_2.name

	local var_7_0 = gohelper.findChildClick(arg_7_1, "btn")

	arg_7_0:addClickCb(var_7_0, arg_7_0["_onBtnClick" .. arg_7_3], arg_7_0)
end

function var_0_0._onBtnClick1(arg_8_0)
	ZProj.UGUIHelper.CopyText(arg_8_0._logText.text)
end

function var_0_0.addLog(arg_9_0, arg_9_1)
	table.insert(arg_9_0._strList, arg_9_1)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
