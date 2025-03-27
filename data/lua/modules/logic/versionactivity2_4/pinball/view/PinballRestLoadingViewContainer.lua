module("modules.logic.versionactivity2_4.pinball.view.PinballRestLoadingViewContainer", package.seeall)

slot0 = class("PinballRestLoadingViewContainer", PinballLoadingViewContainer)

function slot0.buildViews(slot0)
	return {}
end

function slot0.onContainerOpen(slot0, ...)
	uv0.super.onContainerOpen(slot0, ...)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio10)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "bg/#txt_dec"), PinballModel.instance.restCdDay <= 0)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "bg/#txt_dec2"), PinballModel.instance.restCdDay > 0)

	slot0._openDt = UnityEngine.Time.realtimeSinceStartup
end

function slot0.onContainerClickModalMask(slot0)
	if not slot0._openDt or UnityEngine.Time.realtimeSinceStartup - slot0._openDt > 1 then
		slot0:closeThis()
	end
end

function slot0.onContainerClose(slot0, ...)
	uv0.super.onContainerClose(slot0, ...)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio11)
end

return slot0
