module("modules.logic.fight.view.work.FightTweenWork", package.seeall)

slot0 = class("FightTweenWork", FightWorkItem)
slot1 = ZProj.TweenHelper

function slot0.onConstructor(slot0, slot1)
	slot0:setParam(slot1)
end

function slot0.setParam(slot0, slot1)
	slot0.param = slot1

	slot0:_ctorCheckParam()
end

function slot0.onStart(slot0)
	if uv0.FuncDict[slot0.param.type] then
		slot0._tweenId = slot1(slot0, slot0.param)

		slot0:cancelFightWorkSafeTimer()
	else
		logError("声明了一个不存在的动画类型" .. slot0.param.type)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	if slot0._tweenId then
		uv0.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._onTweenEnd(slot0)
	slot0:onDone(true)
end

function slot0.DOTweenFloat(slot0, slot1)
	return uv0.DOTweenFloat(slot1.from, slot1.to, slot1.t, slot0._tweenFloatFrameCb, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0._tweenFloatFrameCb(slot0, slot1)
	if slot0.param and slot0.param.frameCb then
		if slot0.param.cbObj then
			slot0.param.frameCb(slot0.param.cbObj, slot1, slot0.param.param)
		else
			slot0.param.frameCb(slot1, slot0.param.param)
		end
	end
end

function slot0.DOAnchorPos(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOAnchorPos(slot1.tr, slot1.tox, slot1.toy, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOAnchorPosX(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOAnchorPosX(slot1.tr, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOAnchorPosY(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOAnchorPosY(slot1.tr, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOWidth(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOWidth(slot1.tr, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOHeight(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOHeight(slot1.tr, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOSizeDelta(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOSizeDelta(slot1.tr, slot1.tox, slot1.toy, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOMove(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOMove(slot1.tr, slot1.tox, slot1.toy, slot1.toz, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOMoveX(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOMoveX(slot1.tr, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOMoveY(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOMoveY(slot1.tr, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOLocalMove(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOLocalMove(slot1.tr, slot1.tox, slot1.toy, slot1.toz, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOLocalMoveX(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOLocalMoveX(slot1.tr, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOLocalMoveY(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOLocalMoveY(slot1.tr, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOScale(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	slot2 = EaseType.Str2Type(slot1.ease)
	slot3 = slot1.tox
	slot4 = slot1.toy
	slot5 = slot1.toz

	if slot1.to then
		slot5 = slot1.to
		slot4 = slot1.to
		slot3 = slot1.to
	end

	return uv0.DOScale(slot1.tr, slot3, slot4, slot5, slot1.t, slot0._onTweenEnd, slot0, nil, slot2)
end

function slot0.DORotate(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DORotate(slot1.tr, slot1.tox, slot1.toy, slot1.toz, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOLocalRotate(slot0, slot1)
	if slot0:_checkObjNil(slot1.tr) then
		return
	end

	return uv0.DOLocalRotate(slot1.tr, slot1.tox, slot1.toy, slot1.toz, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOFadeCanvasGroup(slot0, slot1)
	if slot0:_checkObjNil(slot1.go) then
		return
	end

	return uv0.DOFadeCanvasGroup(slot1.go, slot1.from or -1, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0.DOFillAmount(slot0, slot1)
	if slot0:_checkObjNil(slot1.img) then
		return
	end

	return uv0.DOFillAmount(slot1.img, slot1.to, slot1.t, slot0._onTweenEnd, slot0, nil, EaseType.Str2Type(slot1.ease))
end

function slot0._checkObjNil(slot0, slot1)
	return gohelper.isNil(slot1)
end

slot0.FuncDict = {
	DOTweenFloat = slot0.DOTweenFloat,
	DOAnchorPos = slot0.DOAnchorPos,
	DOAnchorPosX = slot0.DOAnchorPosX,
	DOAnchorPosY = slot0.DOAnchorPosY,
	DOWidth = slot0.DOWidth,
	DOHeight = slot0.DOHeight,
	DOSizeDelta = slot0.DOSizeDelta,
	DOMove = slot0.DOMove,
	DOMoveX = slot0.DOMoveX,
	DOMoveY = slot0.DOMoveY,
	DOLocalMove = slot0.DOLocalMove,
	DOLocalMoveX = slot0.DOLocalMoveX,
	DOLocalMoveY = slot0.DOLocalMoveY,
	DOScale = slot0.DOScale,
	DORotate = slot0.DORotate,
	DOLocalRotate = slot0.DOLocalRotate,
	DOFadeCanvasGroup = slot0.DOFadeCanvasGroup,
	DOFillAmount = slot0.DOFillAmount
}
slot2 = "number"
slot4 = "userdata"
slot6 = "UnityEngine.(.-)Transform"
slot0.CheckParamList = {
	DOTweenFloat = {
		{
			{
				"from",
				slot2
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			},
			{
				"frameCb",
				"function"
			}
		}
	},
	DOAnchorPos = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"tox",
				slot2
			},
			{
				"toy",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOAnchorPosX = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOAnchorPosY = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOWidth = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOHeight = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOSizeDelta = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"tox",
				slot2
			},
			{
				"toy",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOMove = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"tox",
				slot2
			},
			{
				"toy",
				slot2
			},
			{
				"toz",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOMoveX = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOMoveY = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOLocalMove = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"tox",
				slot2
			},
			{
				"toy",
				slot2
			},
			{
				"toz",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOLocalMoveX = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOLocalMoveY = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DORotate = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"tox",
				slot2
			},
			{
				"toy",
				slot2
			},
			{
				"toz",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOLocalRotate = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"tox",
				slot2
			},
			{
				"toy",
				slot2
			},
			{
				"toz",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOFadeCanvasGroup = {
		{
			{
				"go",
				slot4,
				"UnityEngine.GameObject"
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOFillAmount = {
		{
			{
				"img",
				slot4,
				"UnityEngine.UI.Image"
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	},
	DOScale = {
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"tox",
				slot2
			},
			{
				"toy",
				slot2
			},
			{
				"toz",
				slot2
			},
			{
				"t",
				slot2
			}
		},
		{
			{
				"tr",
				slot4,
				slot6
			},
			{
				"to",
				slot2
			},
			{
				"t",
				slot2
			}
		}
	}
}

function slot0._ctorCheckParam(slot0)
	if not uv0.CheckParamList[slot0.param.type] then
		logError("FightTweenWork check param not implement: " .. slot0.param.type)

		return
	end

	slot2 = nil

	for slot6, slot7 in ipairs(slot1) do
		slot8 = false
		slot9, slot2 = slot0:_checkOneParam(slot7)

		if slot9 then
			return
		end
	end

	logError(slot2)
end

function slot0._checkOneParam(slot0, slot1)
	slot2 = true
	slot3 = nil

	for slot7, slot8 in ipairs(slot1) do
		slot10 = slot8[2]
		slot11 = slot8[3]
		slot12 = slot0.param[slot8[1]]
		slot13 = type(slot12)

		if slot12 == nil then
			slot2 = false
			slot3 = string.format("FightTweenWork param is nil: %s.%s", slot0.param.type, slot9)
		elseif slot13 == "userdata" then
			if gohelper.isNil(slot12) then
				slot2 = false
				slot3 = string.format("FightTweenWork userdata isNil: %s.%s", slot0.param.type, slot9)
			elseif not string.find(tostring(slot12), slot11) then
				slot2 = false

				logError(string.format("FightTweenWork userdata type not match: %s.%s, expect %s but %s", slot0.param.type, slot9, slot11, tostring(slot12)))
			end
		elseif slot13 ~= slot10 then
			slot2 = false
			slot3 = string.format("FightTweenWork type not match: %s.%s, expect %s but %s", slot0.param.type, slot9, slot10, slot13)
		end
	end

	return slot2, slot3
end

return slot0
