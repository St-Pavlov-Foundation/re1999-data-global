module("modules.logic.versionactivity1_4.act129.view.Activity129View", package.seeall)

slot0 = class("Activity129View", BaseView)

function slot0.onInitView(slot0)
	slot0.simageBg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.simageBg:LoadImage("singlebg/v1a4_tokenstore_singlebg/v1a4_tokenstore_fullbg1.png")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	Activity129Rpc.instance:sendGet129InfosRequest(slot0.actId)
	ActivityEnterMgr.instance:enterActivity(slot0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot0.actId
	})
end

function slot0.onClose(slot0)
	Activity129Model.instance:setSelectPoolId(nil, true)
end

function slot0.onDestroyView(slot0)
	slot0.simageBg:UnLoadImage()
end

return slot0
