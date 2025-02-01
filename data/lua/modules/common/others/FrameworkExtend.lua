module("modules.common.others.FrameworkExtend", package.seeall)

slot0 = class("FrameworkExtend", LuaCompBase)

function slot0.init()
	UILayerName.PopUpSecond = "POPUP_SECOND"
	UILayerName.PopUpBlur = "POPUPBlur"
end

return slot0
