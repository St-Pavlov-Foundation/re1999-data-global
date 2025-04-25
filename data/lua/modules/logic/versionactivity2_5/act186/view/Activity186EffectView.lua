module("modules.logic.versionactivity2_5.act186.view.Activity186EffectView", package.seeall)

slot0 = class("Activity186EffectView", BaseView)

function slot0.onInitView(slot0)
	slot0.effectList = slot0:getUserDataTb_()

	for slot4 = 1, 4 do
		slot0.effectList[slot4] = gohelper.findChild(slot0.viewGO, "#go_effect" .. slot4)
	end

	slot0.audioIdList = {
		[Activity186Enum.ViewEffect.Caidai] = AudioEnum.Act186.play_ui_tangren_banger,
		[Activity186Enum.ViewEffect.Yanhua] = AudioEnum.Act186.play_ui_tangren_firework,
		[Activity186Enum.ViewEffect.Jinsha] = AudioEnum.Act186.play_ui_tangren_mysticism,
		[Activity186Enum.ViewEffect.Xiangyun] = AudioEnum.Act186.play_ui_tangren_cloud
	}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnClose(slot0)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.effectId = slot0.viewParam.effectId
end

function slot0.refreshView(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)

	for slot4, slot5 in ipairs(slot0.effectList) do
		gohelper.setActive(slot5, false)

		if slot4 == slot0.effectId then
			gohelper.setActive(slot5, true)
		end
	end

	if slot0.audioIdList[slot0.effectId] then
		AudioMgr.instance:trigger(slot1)
	end
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)
end

function slot0.onDestroyView(slot0)
end

return slot0
