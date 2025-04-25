module("modules.logic.fight.view.FightSeasonSubHeroItem", package.seeall)

slot0 = class("FightSeasonSubHeroItem", FightBaseView)

function slot0.onInitView(slot0)
	slot0._headIcon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Head")
	slot0._hpSlider = gohelper.findChildImage(slot0.viewGO, "infoPart/HP/#image_HPFG")
	slot0._pointRoot = gohelper.findChild(slot0.viewGO, "infoPart/Point")
	slot0._pointItem = gohelper.findChild(slot0.viewGO, "infoPart/Point/pointItem")
	slot0._btn = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "btn")
	slot0._aniPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._ani = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
	slot0._fillImage = gohelper.findChildImage(slot0.viewGO, "#image_ItemBGFilled")
	slot1 = UnityEngine.Object.Instantiate(slot0._fillImage.material)
	slot0._fillImage.material = slot1
	slot0._fillMat = slot1
	slot0._hpRoot = gohelper.findChild(slot0.viewGO, "infoPart")
	slot0._effectHeal = gohelper.findChild(slot0.viewGO, "infoPart/eff_heal")
	slot0._infoPart = gohelper.findChild(slot0.viewGO, "infoPart")
	slot0._point2Root = gohelper.findChild(slot0.viewGO, "infoPart/Point2")
	slot0._point2Item = gohelper.findChild(slot0.viewGO, "infoPart/Point2/pointItem")
end

function slot0.addEvents(slot0)
	slot0:com_registClick(slot0._btn, slot0._onBtnClick)
	slot0:com_registFightEvent(FightEvent.OnExPointChange, slot0._onExPointChange)
	slot0:com_registFightEvent(FightEvent.UpdateExPoint, slot0._onUpdateExPoint)
	slot0:com_registFightEvent(FightEvent.ReplaceEntityMO, slot0._onReplaceEntityMO)
	slot0:com_registFightEvent(FightEvent.BeforeChangeSubHero, slot0._onBeforeChangeSubHero)
	slot0:com_registFightEvent(FightEvent.ChangeSubEntityHp, slot0._onChangeSubEntityHp)
	slot0:com_registFightEvent(FightEvent.EntitySync, slot0._onEntitySync)
	slot0:com_registFightEvent(FightEvent.ChangeEntitySubCd, slot0._onChangeEntitySubCd)
	slot0:com_registFightEvent(FightEvent.StageChanged, slot0._onStageChanged)
end

function slot0.removeEvents(slot0)
end

function slot0._onExPointChange(slot0, slot1, slot2, slot3)
	if slot1 == slot0._entityId then
		slot0._hideInfoTimer = slot0:com_registSingleTimer(slot0._hideInfoTimer, slot0._delayHideInfo, 0.6)

		slot0:_refreshExpoint(true, slot2, slot3)

		if slot0:_canUse() then
			slot0:playAni("max_in", true)
			AudioMgr.instance:trigger(410000105)
		else
			slot0:refreshAni()
		end

		if slot3 == 5 then
			FightController.instance:dispatchEvent(FightEvent.GuideSubEntityExpoint5)
		end
	end
end

function slot0._delayHideInfo(slot0)
	slot1 = slot0:_canUse()

	gohelper.setActive(slot0._effectHeal, false)
end

function slot0._onUpdateExPoint(slot0, slot1, slot2, slot3)
	slot0:_onExPointChange(slot1, slot2, slot3)
end

function slot0._onReplaceEntityMO(slot0, slot1)
	if slot1.id == slot0._entityId then
		slot0:refreshData(slot0._entityId)
	end
end

function slot0._onBeforeChangeSubHero(slot0, slot1, slot2)
	if slot2 == slot0._entityId then
		if slot1 == "0" then
			slot0.PARENT_VIEW:onOpen()
		else
			slot0:refreshData(slot1)
		end
	end
end

function slot0._onChangeSubEntityHp(slot0, slot1, slot2)
	if slot1 == slot0._entityId then
		slot0:_refreshHp(true)

		if slot2 > 0 then
			slot0._hideInfoTimer = slot0:com_registSingleTimer(slot0._hideInfoTimer, slot0._delayHideInfo, 0.6)

			gohelper.setActive(slot0._effectHeal, true)
		end
	end
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._effectHeal, false)
end

function slot0._canUse(slot0)
	slot1 = FightDataHelper.entityMgr:getById(slot0._entityId)

	if slot1:getUniqueSkillPoint() <= slot1:getExPoint() then
		return true
	end
end

function slot0._onBtnClick(slot0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if not slot0:_canUse() then
		return
	end

	if FightDataHelper.entityMgr:getById(slot0._entityId).subCd ~= 0 then
		GameFacade.showToast(ToastEnum.CanNotUseSeasonChangeHeroCd)

		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.SeasonChangeHero then
			if slot0.PARENT_VIEW:selecting(slot0) then
				return
			end

			slot0:selectItem()
		end

		return
	end

	slot0.PARENT_VIEW:_enterOperate()
	slot0:selectItem()
end

function slot0.selectItem(slot0)
	AudioMgr.instance:trigger(410000106)
	slot0.PARENT_VIEW:selectItem(slot0)
end

function slot0._onChangeEntitySubCd(slot0, slot1)
	if slot1 == slot0._entityId then
		slot0:refreshAni()
	end
end

function slot0._onEntitySync(slot0, slot1)
	if slot1 == slot0._entityId and FightDataHelper.entityMgr:getById(slot0._entityId).subCd ~= 0 then
		slot0:playAni("cd_in", true)
	end
end

function slot0._onStageChanged(slot0, slot1)
	slot0:refreshAni()
end

function slot0.refreshAni(slot0)
	if not slot0.viewGO.activeInHierarchy then
		return
	end

	if FightDataHelper.entityMgr:getById(slot0._entityId).subCd ~= 0 then
		slot0:playAni("cd_idle", nil, true)
	elseif slot0:_canUse() then
		slot0:playAni("max_idle", nil, true)
	else
		slot0:playAni("normal_idle", nil, true)
	end
end

function slot0.playAni(slot0, slot1, slot2, slot3)
	if not slot0.viewGO.activeInHierarchy then
		return
	end

	if slot1 == "select_in" then
		slot0._aniPlayer:Play(slot1, nil, )
	elseif slot2 then
		slot0._aniPlayer:Play(slot1, slot0.refreshAni, slot0)
	elseif slot3 then
		slot0._ani.enabled = true

		slot0._ani:Play(slot1)
	else
		slot0._aniPlayer:Play(slot1, nil, )
	end
end

function slot0.refreshData(slot0, slot1)
	slot0._entityId = slot1

	slot0._headIcon:LoadImage(ResUrl.roomHeadIcon(SkinConfig.instance:getSkinCo(FightDataHelper.entityMgr:getById(slot0._entityId).skin).headIcon))
	slot0:_refreshExpoint()
	slot0:_refreshHp()
	slot0:refreshAni()

	slot4 = slot0:_canUse()
end

function slot0._buildDataListByNum(slot0, slot1)
	slot2 = {}

	for slot6 = 1, slot1 do
		table.insert(slot2, slot6)
	end

	return slot2
end

function slot0._refreshExpoint(slot0, slot1, slot2, slot3)
	slot4 = FightDataHelper.entityMgr:getById(slot0._entityId)
	slot0._expointObj = {}
	slot0._expointMax = slot4:getMaxExPoint()
	slot0._curExpoint = slot4:getExPoint()

	gohelper.setActive(slot0._point2Root, false)

	if slot0._expointMax <= 6 then
		gohelper.CreateObjList(slot0, slot0._onPointItemShow, slot0:_buildDataListByNum(math.min(slot0._expointMax, 6)), slot0._pointRoot, slot0._pointItem)
	elseif slot0._expointMax <= 12 then
		gohelper.setActive(slot0._point2Root, true)
		gohelper.CreateObjList(slot0, slot0._onPointItemShow, slot0:_buildDataListByNum(6), slot0._pointRoot, slot0._pointItem)
		gohelper.CreateObjList(slot0, slot0._onPoint2ItemShow, slot0:_buildDataListByNum(slot0._expointMax - 6), slot0._point2Root, slot0._point2Item)
	else
		gohelper.CreateObjList(slot0, slot0._onPointItemShow, slot0:_buildDataListByNum(slot0._expointMax), slot0._pointRoot, slot0._pointItem)
	end

	for slot8, slot9 in ipairs(slot0._expointObj) do
		gohelper.setActive(slot9.light, slot8 <= slot0._curExpoint)
	end

	slot5 = slot4:getUniqueSkillPoint()

	if slot1 and slot2 and slot3 then
		slot0:_releaseTween()

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot2 / slot5, slot3 / slot5, 0.3 / FightModel.instance:getUISpeed(), slot0._expointTweenCallback, nil, slot0)

		if slot2 < slot3 then
			for slot9 = slot2 + 1, slot3 do
				if slot0._expointObj[slot9] and slot0.viewGO.activeInHierarchy then
					slot0._expointObj[slot9].ani:Play("in", nil, )
				end
			end
		end
	else
		slot0._fillMat:SetFloat("_LerpOffset", slot0._curExpoint / slot5)
	end
end

function slot0._expointTweenCallback(slot0, slot1)
	slot0._fillMat:SetFloat("_LerpOffset", slot1)
end

function slot0._releaseTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._onPointItemShow(slot0, slot1, slot2, slot3)
	if not slot0._expointObj[slot3] then
		slot0._expointObj[slot3] = slot0:newUserDataTable()
		slot0._expointObj[slot3].light = gohelper.findChild(slot1, "#go_FG")
		slot0._expointObj[slot3].mask = gohelper.findChild(slot1, "#go_Mask")
		slot0._expointObj[slot3].ani = SLFramework.AnimatorPlayer.Get(slot1)
	end
end

function slot0._onPoint2ItemShow(slot0, slot1, slot2, slot3)
	if not slot0._expointObj[slot3 + 6] then
		slot0._expointObj[slot3] = slot0:newUserDataTable()
		slot0._expointObj[slot3].light = gohelper.findChild(slot1, "#go_FG")
		slot0._expointObj[slot3].mask = gohelper.findChild(slot1, "#go_Mask")
		slot0._expointObj[slot3].ani = SLFramework.AnimatorPlayer.Get(slot1)
	end
end

function slot0._refreshHp(slot0, slot1)
	slot2 = FightDataHelper.entityMgr:getById(slot0._entityId)

	if slot1 then
		slot0:_releaseHpTween()

		slot0._hpTween = ZProj.TweenHelper.DOFillAmount(slot0._hpSlider, slot2.currentHp / slot2.attrMO.hp, 0.3)
	else
		slot0._hpSlider.fillAmount = slot4 / slot3
	end
end

function slot0._releaseHpTween(slot0)
	if slot0._hpTween then
		ZProj.TweenHelper.KillById(slot0._hpTween)

		slot0._hpTween = nil
	end
end

function slot0.onClose(slot0)
	slot0:_releaseTween()
	slot0:_releaseHpTween()
end

function slot0.onDestroyView(slot0)
end

return slot0
