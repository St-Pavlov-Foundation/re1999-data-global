module("modules.logic.seasonver.act166.view.Season166WordEffectView", package.seeall)

slot0 = class("Season166WordEffectView", BaseView)

function slot0.onInitView(slot0)
	slot0.content = gohelper.findChild(slot0.viewGO, "#go_wordEffectContent")
end

function slot0.onOpen(slot0)
	slot0.wordContentGO = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot0.content)
	slot0.wordEffect = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[2], slot0.wordContentGO)
	slot0.viewType = slot0.viewParam.viewType
	slot0.actId = slot0.viewParam.actId

	gohelper.setActive(slot0.wordContentGO, false)
	gohelper.setActive(slot0.wordEffect, false)

	slot0.wordEffectConfigList = Season166Config.instance:getSeasonWordEffectConfigList(slot0.viewParam.actId, slot0.viewType)

	TaskDispatcher.runRepeat(slot0._createWord, slot0, Season166Enum.WordInterval, -1)
	slot0:_createWord()
end

function slot0._createWord(slot0)
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_aekn_piaozi)

	if not slot0._nowPosIndex then
		slot0._nowPosIndex = math.random(1, #slot0.wordEffectConfigList)
	else
		if slot0._nowPosIndex <= math.random(1, #slot0.wordEffectConfigList - 1) then
			slot1 = slot1 + 1
		end

		slot0._nowPosIndex = slot1
	end

	slot0._coIndexSort = slot0._coIndexSort or {}

	if slot0._coIndexSort[1] then
		slot0._nowCoIndex = table.remove(slot0._coIndexSort, 1)
	else
		for slot4 = 1, #slot0.wordEffectConfigList do
			slot0._coIndexSort[slot4] = slot4
		end

		slot0._coIndexSort = GameUtil.randomTable(slot0._coIndexSort)

		if slot0._nowCoIndex == slot0._coIndexSort[1] then
			slot0._nowCoIndex = table.remove(slot0._coIndexSort, 2)
		else
			slot0._nowCoIndex = table.remove(slot0._coIndexSort, 1)
		end
	end

	slot1 = gohelper.cloneInPlace(slot0.wordContentGO)

	gohelper.setActive(slot1, true)

	slot2 = slot0.wordEffectConfigList[slot0._nowCoIndex]
	slot4 = string.splitToNumber(Season166Config.instance:getSeasonWordEffectPosConfig(slot0.actId, slot2.id).pos, "#")

	recthelper.setAnchor(slot1.transform, slot4[1], slot4[2])
	MonoHelper.addNoUpdateLuaComOnceToGo(slot1, Season166WordEffectComp, {
		co = slot2,
		res = slot0.wordEffect
	})
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._createWord, slot0)
end

return slot0
