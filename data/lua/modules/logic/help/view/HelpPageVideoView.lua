module("modules.logic.help.view.HelpPageVideoView", package.seeall)

local var_0_0 = class("HelpPageVideoView", BaseView)

function var_0_0.onInitView(arg_1_0)
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
	arg_4_0._voideItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0.viewGO, HelpContentVideoItem, arg_4_0)
	arg_4_0._voideItem._view = arg_4_0
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	if arg_6_0.viewContainer then
		arg_6_0:addEventCb(arg_6_0.viewContainer, HelpEvent.UIVoideFullScreenChange, arg_6_0._onVoideFullScreenChange, arg_6_0)
		arg_6_0:addEventCb(arg_6_0.viewContainer, HelpEvent.UIPageTabSelectChange, arg_6_0._onUIPageTabSelectChange, arg_6_0)
	end
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._voideItem:onDestroy()
end

function var_0_0._onVoideFullScreenChange(arg_9_0, arg_9_1)
	if arg_9_0.viewContainer and arg_9_0.viewContainer.setVideoFullScreen then
		arg_9_0.viewContainer:setVideoFullScreen(arg_9_0._voideItem:getIsFullScreen())
	end
end

function var_0_0._onUIPageTabSelectChange(arg_10_0, arg_10_1)
	arg_10_0:setPageTabCfg(arg_10_1)
end

function var_0_0.setPageTabCfg(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	if arg_11_1.showType == HelpEnum.PageTabShowType.Video and arg_11_0._curShowHelpId ~= arg_11_1.helpId then
		arg_11_0._curShowHelpId = arg_11_1.helpId

		local var_11_0 = HelpConfig.instance:getHelpVideoCO(arg_11_0._curShowHelpId)

		if var_11_0 then
			arg_11_0._voideItem:onUpdateMO(var_11_0)
		else
			logError(string.format("export_帮助视频表 can not find id : %s", arg_11_0._curShowHelpId))
		end
	elseif arg_11_1.showType ~= HelpEnum.PageTabShowType.Video then
		arg_11_0._voideItem:stop()
	end
end

return var_0_0
