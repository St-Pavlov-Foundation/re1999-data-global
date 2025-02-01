module("modules.logic.rouge.map.view.nextlayer.RougeNextLayerView", package.seeall)

slot0 = class("RougeNextLayerView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagetitlebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_titlebg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#txt_dec")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagefullbg:LoadImage("singlebg/rouge/map/rouge_map_nextlevelbg.png")
	slot0._simagetitlebg:LoadImage("singlebg/rouge/map/rouge_map_nextlevelbg2.png")
	NavigateMgr.instance:addEscape(slot0.viewName, RougeMapHelper.blockEsc, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onLoadMapDone, slot0.onLoadMapDone, slot0)
end

function slot0.onLoadMapDone(slot0)
	slot0.loadDone = true

	slot0:closeView()
end

function slot0.closeView(slot0)
	if not slot0.loadDone or not slot0.overMinTime then
		return
	end

	slot0:closeThis()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.SwitchNormalLayer)

	slot0.loadDone = not RougeMapModel.instance:checkIsLoading()
	slot0.overMinTime = false
	slot2 = lua_rouge_layer.configDict[slot0.viewParam]
	slot0._txttitle.text = slot2.name
	slot0._txtdec.text = slot2.crossDesc

	TaskDispatcher.runDelay(slot0.onMinTimeDone, slot0, RougeMapEnum.SwitchLayerMinDuration)
	TaskDispatcher.runDelay(slot0.onMaxTimeDone, slot0, RougeMapEnum.SwitchLayerMaxDuration)
end

function slot0.onMinTimeDone(slot0)
	slot0.overMinTime = true

	slot0:closeView()
end

function slot0.onMaxTimeDone(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.onMinTimeDone, slot0)
	TaskDispatcher.cancelTask(slot0.onMaxTimeDone, slot0)
	slot0._simagefullbg:UnLoadImage()
	slot0._simagetitlebg:UnLoadImage()
end

return slot0
