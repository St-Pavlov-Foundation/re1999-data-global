module("modules.logic.help.view.HelpPageVideoView", package.seeall)

slot0 = class("HelpPageVideoView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._voideItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, HelpContentVideoItem, slot0)
	slot0._voideItem._view = slot0
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, HelpEvent.UIVoideFullScreenChange, slot0._onVoideFullScreenChange, slot0)
		slot0:addEventCb(slot0.viewContainer, HelpEvent.UIPageTabSelectChange, slot0._onUIPageTabSelectChange, slot0)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._voideItem:onDestroy()
end

function slot0._onVoideFullScreenChange(slot0, slot1)
	if slot0.viewContainer and slot0.viewContainer.setVideoFullScreen then
		slot0.viewContainer:setVideoFullScreen(slot0._voideItem:getIsFullScreen())
	end
end

function slot0._onUIPageTabSelectChange(slot0, slot1)
	slot0:setPageTabCfg(slot1)
end

function slot0.setPageTabCfg(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1.showType == HelpEnum.PageTabShowType.Video and slot0._curShowHelpId ~= slot1.helpId then
		slot0._curShowHelpId = slot1.helpId

		if HelpConfig.instance:getHelpVideoCO(slot0._curShowHelpId) then
			slot0._voideItem:onUpdateMO(slot2)
		else
			logError(string.format("export_帮助视频表 can not find id : %s", slot0._curShowHelpId))
		end
	elseif slot1.showType ~= HelpEnum.PageTabShowType.Video then
		slot0._voideItem:stop()
	end
end

return slot0
