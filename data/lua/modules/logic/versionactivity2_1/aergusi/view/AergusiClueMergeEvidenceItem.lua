module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueMergeEvidenceItem", package.seeall)

local var_0_0 = class("AergusiClueMergeEvidenceItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "select")
	arg_1_0._simageclue = gohelper.findChildSingleImage(arg_1_1, "select/simage_clue")
	arg_1_0._txtcluename = gohelper.findChildText(arg_1_1, "select/name")
	arg_1_0._goempty = gohelper.findChild(arg_1_1, "empty")
	arg_1_0._goselectframe = gohelper.findChild(arg_1_1, "empty/selectframe")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "clickarea")

	arg_1_0:_addEvents()
	gohelper.setActive(arg_1_0._goempty, true)
	arg_1_0:refreshItem()
end

function var_0_0.refreshItem(arg_2_0)
	local var_2_0 = AergusiModel.instance:getMergeClueState().pos[arg_2_0._index]

	gohelper.setActive(arg_2_0._goselectframe, var_2_0 and var_2_0.selected)
	gohelper.setActive(arg_2_0._goselect, var_2_0 and var_2_0.clueId > 0)

	if var_2_0 and var_2_0.clueId > 0 then
		local var_2_1 = AergusiConfig.instance:getClueConfig(var_2_0.clueId)

		arg_2_0._simageclue:LoadImage(ResUrl.getV2a1AergusiSingleBg(var_2_1.clueIcon))

		arg_2_0._txtcluename.text = var_2_1.clueName
	else
		arg_2_0._txtcluename.text = ""

		arg_2_0._simageclue:UnLoadImage()
	end
end

function var_0_0._addEvents(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnClueOnClick, arg_3_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeItem, arg_3_0.refreshItem, arg_3_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeSelect, arg_3_0.refreshItem, arg_3_0)
end

function var_0_0._removeEvents(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeItem, arg_4_0.refreshItem, arg_4_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeSelect, arg_4_0.refreshItem, arg_4_0)
end

function var_0_0._btnClueOnClick(arg_5_0)
	if not AergusiModel.instance:getClueMergePosSelectState(arg_5_0._index) then
		AergusiModel.instance:setClueMergePosSelect(arg_5_0._index, true)
	else
		AergusiModel.instance:setClueMergePosClueId(arg_5_0._index, 0)
		arg_5_0:refreshItem()
	end

	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickClueMergeItem)
end

function var_0_0.destroy(arg_6_0)
	arg_6_0._simageclue:UnLoadImage()
	arg_6_0:_removeEvents()
end

return var_0_0
