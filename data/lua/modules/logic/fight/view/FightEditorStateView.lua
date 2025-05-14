module("modules.logic.fight.view.FightEditorStateView", package.seeall)

local var_0_0 = class("FightEditorStateView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnListRoot = gohelper.findChild(arg_1_0.viewGO, "root/topLeft/ScrollView/Viewport/Content")
	arg_1_0._btnModel = gohelper.findChild(arg_1_0._btnListRoot, "btnModel")
	arg_1_0._center = gohelper.findChild(arg_1_0.viewGO, "root/center")
	arg_1_0._closeBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/topRight/Button")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._closeBtn, arg_2_0._onBtnClose, arg_2_0)
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

function var_0_0._onBtnClose(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = {
		{
			name = "最后一回合"
		},
		{
			name = "战场日志"
		}
	}

	arg_7_0:com_createObjList(arg_7_0._onBtnItemShow, var_7_0, arg_7_0._btnListRoot, arg_7_0._btnModel)
	arg_7_0:_onBtnClick1()
end

function var_0_0._onBtnItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	gohelper.findChildText(arg_8_1, "text").text = arg_8_2.name

	local var_8_0 = gohelper.findChildClick(arg_8_1, "btn")

	arg_8_0:addClickCb(var_8_0, arg_8_0["_onBtnClick" .. arg_8_3], arg_8_0)
end

function var_0_0._onBtnClick1(arg_9_0)
	arg_9_0:openExclusiveView(nil, 1, FightEditorStateLastRoundLogView, "ui/viewres/fight/fighteditorstatelogview.prefab", arg_9_0._center)
end

function var_0_0._onBtnClick2(arg_10_0)
	arg_10_0:openExclusiveView(nil, 2, FightEditorStateLogView, "ui/viewres/fight/fighteditorstatelogview.prefab", arg_10_0._center)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
