module("modules.logic.fight.view.work.FightTweenWork", package.seeall)

local var_0_0 = class("FightTweenWork", FightWorkItem)
local var_0_1 = ZProj.TweenHelper

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0:setParam(arg_1_1)
end

function var_0_0.setParam(arg_2_0, arg_2_1)
	arg_2_0.param = arg_2_1

	arg_2_0:_ctorCheckParam()
end

function var_0_0.onStart(arg_3_0)
	local var_3_0 = var_0_0.FuncDict[arg_3_0.param.type]

	if var_3_0 then
		arg_3_0._tweenId = var_3_0(arg_3_0, arg_3_0.param)

		arg_3_0:cancelFightWorkSafeTimer()
	else
		logError("声明了一个不存在的动画类型" .. arg_3_0.param.type)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._tweenId then
		var_0_1.KillById(arg_4_0._tweenId)

		arg_4_0._tweenId = nil
	end
end

function var_0_0._onTweenEnd(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0.DOTweenFloat(arg_6_0, arg_6_1)
	local var_6_0 = EaseType.Str2Type(arg_6_1.ease)

	return var_0_1.DOTweenFloat(arg_6_1.from, arg_6_1.to, arg_6_1.t, arg_6_0._tweenFloatFrameCb, arg_6_0._onTweenEnd, arg_6_0, nil, var_6_0)
end

function var_0_0._tweenFloatFrameCb(arg_7_0, arg_7_1)
	if arg_7_0.param and arg_7_0.param.frameCb then
		if arg_7_0.param.cbObj then
			arg_7_0.param.frameCb(arg_7_0.param.cbObj, arg_7_1, arg_7_0.param.param)
		else
			arg_7_0.param.frameCb(arg_7_1, arg_7_0.param.param)
		end
	end
end

function var_0_0.DOAnchorPos(arg_8_0, arg_8_1)
	if arg_8_0:_checkObjNil(arg_8_1.tr) then
		return
	end

	local var_8_0 = EaseType.Str2Type(arg_8_1.ease)

	return var_0_1.DOAnchorPos(arg_8_1.tr, arg_8_1.tox, arg_8_1.toy, arg_8_1.t, arg_8_0._onTweenEnd, arg_8_0, nil, var_8_0)
end

function var_0_0.DOAnchorPosX(arg_9_0, arg_9_1)
	if arg_9_0:_checkObjNil(arg_9_1.tr) then
		return
	end

	local var_9_0 = EaseType.Str2Type(arg_9_1.ease)

	return var_0_1.DOAnchorPosX(arg_9_1.tr, arg_9_1.to, arg_9_1.t, arg_9_0._onTweenEnd, arg_9_0, nil, var_9_0)
end

function var_0_0.DOAnchorPosY(arg_10_0, arg_10_1)
	if arg_10_0:_checkObjNil(arg_10_1.tr) then
		return
	end

	local var_10_0 = EaseType.Str2Type(arg_10_1.ease)

	return var_0_1.DOAnchorPosY(arg_10_1.tr, arg_10_1.to, arg_10_1.t, arg_10_0._onTweenEnd, arg_10_0, nil, var_10_0)
end

function var_0_0.DOWidth(arg_11_0, arg_11_1)
	if arg_11_0:_checkObjNil(arg_11_1.tr) then
		return
	end

	local var_11_0 = EaseType.Str2Type(arg_11_1.ease)

	return var_0_1.DOWidth(arg_11_1.tr, arg_11_1.to, arg_11_1.t, arg_11_0._onTweenEnd, arg_11_0, nil, var_11_0)
end

function var_0_0.DOHeight(arg_12_0, arg_12_1)
	if arg_12_0:_checkObjNil(arg_12_1.tr) then
		return
	end

	local var_12_0 = EaseType.Str2Type(arg_12_1.ease)

	return var_0_1.DOHeight(arg_12_1.tr, arg_12_1.to, arg_12_1.t, arg_12_0._onTweenEnd, arg_12_0, nil, var_12_0)
end

function var_0_0.DOSizeDelta(arg_13_0, arg_13_1)
	if arg_13_0:_checkObjNil(arg_13_1.tr) then
		return
	end

	local var_13_0 = EaseType.Str2Type(arg_13_1.ease)

	return var_0_1.DOSizeDelta(arg_13_1.tr, arg_13_1.tox, arg_13_1.toy, arg_13_1.t, arg_13_0._onTweenEnd, arg_13_0, nil, var_13_0)
end

function var_0_0.DOMove(arg_14_0, arg_14_1)
	if arg_14_0:_checkObjNil(arg_14_1.tr) then
		return
	end

	local var_14_0 = EaseType.Str2Type(arg_14_1.ease)

	return var_0_1.DOMove(arg_14_1.tr, arg_14_1.tox, arg_14_1.toy, arg_14_1.toz, arg_14_1.t, arg_14_0._onTweenEnd, arg_14_0, nil, var_14_0)
end

function var_0_0.DOMoveX(arg_15_0, arg_15_1)
	if arg_15_0:_checkObjNil(arg_15_1.tr) then
		return
	end

	local var_15_0 = EaseType.Str2Type(arg_15_1.ease)

	return var_0_1.DOMoveX(arg_15_1.tr, arg_15_1.to, arg_15_1.t, arg_15_0._onTweenEnd, arg_15_0, nil, var_15_0)
end

function var_0_0.DOMoveY(arg_16_0, arg_16_1)
	if arg_16_0:_checkObjNil(arg_16_1.tr) then
		return
	end

	local var_16_0 = EaseType.Str2Type(arg_16_1.ease)

	return var_0_1.DOMoveY(arg_16_1.tr, arg_16_1.to, arg_16_1.t, arg_16_0._onTweenEnd, arg_16_0, nil, var_16_0)
end

function var_0_0.DOLocalMove(arg_17_0, arg_17_1)
	if arg_17_0:_checkObjNil(arg_17_1.tr) then
		return
	end

	local var_17_0 = EaseType.Str2Type(arg_17_1.ease)

	return var_0_1.DOLocalMove(arg_17_1.tr, arg_17_1.tox, arg_17_1.toy, arg_17_1.toz, arg_17_1.t, arg_17_0._onTweenEnd, arg_17_0, nil, var_17_0)
end

function var_0_0.DOLocalMoveX(arg_18_0, arg_18_1)
	if arg_18_0:_checkObjNil(arg_18_1.tr) then
		return
	end

	local var_18_0 = EaseType.Str2Type(arg_18_1.ease)

	return var_0_1.DOLocalMoveX(arg_18_1.tr, arg_18_1.to, arg_18_1.t, arg_18_0._onTweenEnd, arg_18_0, nil, var_18_0)
end

function var_0_0.DOLocalMoveY(arg_19_0, arg_19_1)
	if arg_19_0:_checkObjNil(arg_19_1.tr) then
		return
	end

	local var_19_0 = EaseType.Str2Type(arg_19_1.ease)

	return var_0_1.DOLocalMoveY(arg_19_1.tr, arg_19_1.to, arg_19_1.t, arg_19_0._onTweenEnd, arg_19_0, nil, var_19_0)
end

function var_0_0.DOScale(arg_20_0, arg_20_1)
	if arg_20_0:_checkObjNil(arg_20_1.tr) then
		return
	end

	local var_20_0 = EaseType.Str2Type(arg_20_1.ease)
	local var_20_1 = arg_20_1.tox
	local var_20_2 = arg_20_1.toy
	local var_20_3 = arg_20_1.toz

	if arg_20_1.to then
		var_20_1, var_20_2, var_20_3 = arg_20_1.to, arg_20_1.to, arg_20_1.to
	end

	return var_0_1.DOScale(arg_20_1.tr, var_20_1, var_20_2, var_20_3, arg_20_1.t, arg_20_0._onTweenEnd, arg_20_0, nil, var_20_0)
end

function var_0_0.DORotate(arg_21_0, arg_21_1)
	if arg_21_0:_checkObjNil(arg_21_1.tr) then
		return
	end

	local var_21_0 = EaseType.Str2Type(arg_21_1.ease)

	return var_0_1.DORotate(arg_21_1.tr, arg_21_1.tox, arg_21_1.toy, arg_21_1.toz, arg_21_1.t, arg_21_0._onTweenEnd, arg_21_0, nil, var_21_0)
end

function var_0_0.DOLocalRotate(arg_22_0, arg_22_1)
	if arg_22_0:_checkObjNil(arg_22_1.tr) then
		return
	end

	local var_22_0 = EaseType.Str2Type(arg_22_1.ease)

	return var_0_1.DOLocalRotate(arg_22_1.tr, arg_22_1.tox, arg_22_1.toy, arg_22_1.toz, arg_22_1.t, arg_22_0._onTweenEnd, arg_22_0, nil, var_22_0)
end

function var_0_0.DOFadeCanvasGroup(arg_23_0, arg_23_1)
	if arg_23_0:_checkObjNil(arg_23_1.go) then
		return
	end

	local var_23_0 = EaseType.Str2Type(arg_23_1.ease)

	return var_0_1.DOFadeCanvasGroup(arg_23_1.go, arg_23_1.from or -1, arg_23_1.to, arg_23_1.t, arg_23_0._onTweenEnd, arg_23_0, nil, var_23_0)
end

function var_0_0.DOFillAmount(arg_24_0, arg_24_1)
	if arg_24_0:_checkObjNil(arg_24_1.img) then
		return
	end

	local var_24_0 = EaseType.Str2Type(arg_24_1.ease)

	return var_0_1.DOFillAmount(arg_24_1.img, arg_24_1.to, arg_24_1.t, arg_24_0._onTweenEnd, arg_24_0, nil, var_24_0)
end

function var_0_0._checkObjNil(arg_25_0, arg_25_1)
	return gohelper.isNil(arg_25_1)
end

var_0_0.FuncDict = {
	DOTweenFloat = var_0_0.DOTweenFloat,
	DOAnchorPos = var_0_0.DOAnchorPos,
	DOAnchorPosX = var_0_0.DOAnchorPosX,
	DOAnchorPosY = var_0_0.DOAnchorPosY,
	DOWidth = var_0_0.DOWidth,
	DOHeight = var_0_0.DOHeight,
	DOSizeDelta = var_0_0.DOSizeDelta,
	DOMove = var_0_0.DOMove,
	DOMoveX = var_0_0.DOMoveX,
	DOMoveY = var_0_0.DOMoveY,
	DOLocalMove = var_0_0.DOLocalMove,
	DOLocalMoveX = var_0_0.DOLocalMoveX,
	DOLocalMoveY = var_0_0.DOLocalMoveY,
	DOScale = var_0_0.DOScale,
	DORotate = var_0_0.DORotate,
	DOLocalRotate = var_0_0.DOLocalRotate,
	DOFadeCanvasGroup = var_0_0.DOFadeCanvasGroup,
	DOFillAmount = var_0_0.DOFillAmount
}

local var_0_2 = "number"
local var_0_3 = "function"
local var_0_4 = "userdata"
local var_0_5 = "UnityEngine.GameObject"
local var_0_6 = "UnityEngine.(.-)Transform"
local var_0_7 = "UnityEngine.UI.Image"

var_0_0.CheckParamList = {
	DOTweenFloat = {
		{
			{
				"from",
				var_0_2
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			},
			{
				"frameCb",
				var_0_3
			}
		}
	},
	DOAnchorPos = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"tox",
				var_0_2
			},
			{
				"toy",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOAnchorPosX = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOAnchorPosY = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOWidth = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOHeight = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOSizeDelta = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"tox",
				var_0_2
			},
			{
				"toy",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOMove = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"tox",
				var_0_2
			},
			{
				"toy",
				var_0_2
			},
			{
				"toz",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOMoveX = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOMoveY = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOLocalMove = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"tox",
				var_0_2
			},
			{
				"toy",
				var_0_2
			},
			{
				"toz",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOLocalMoveX = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOLocalMoveY = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DORotate = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"tox",
				var_0_2
			},
			{
				"toy",
				var_0_2
			},
			{
				"toz",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOLocalRotate = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"tox",
				var_0_2
			},
			{
				"toy",
				var_0_2
			},
			{
				"toz",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOFadeCanvasGroup = {
		{
			{
				"go",
				var_0_4,
				var_0_5
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOFillAmount = {
		{
			{
				"img",
				var_0_4,
				var_0_7
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	},
	DOScale = {
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"tox",
				var_0_2
			},
			{
				"toy",
				var_0_2
			},
			{
				"toz",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		},
		{
			{
				"tr",
				var_0_4,
				var_0_6
			},
			{
				"to",
				var_0_2
			},
			{
				"t",
				var_0_2
			}
		}
	}
}

function var_0_0._ctorCheckParam(arg_26_0)
	local var_26_0 = var_0_0.CheckParamList[arg_26_0.param.type]

	if not var_26_0 then
		logError("FightTweenWork check param not implement: " .. arg_26_0.param.type)

		return
	end

	local var_26_1

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_2 = false
		local var_26_3, var_26_4 = arg_26_0:_checkOneParam(iter_26_1)

		var_26_1 = var_26_4

		if var_26_3 then
			return
		end
	end

	logError(var_26_1)
end

function var_0_0._checkOneParam(arg_27_0, arg_27_1)
	local var_27_0 = true
	local var_27_1

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		local var_27_2 = iter_27_1[1]
		local var_27_3 = iter_27_1[2]
		local var_27_4 = iter_27_1[3]
		local var_27_5 = arg_27_0.param[var_27_2]
		local var_27_6 = type(var_27_5)

		if var_27_5 == nil then
			var_27_0 = false
			var_27_1 = string.format("FightTweenWork param is nil: %s.%s", arg_27_0.param.type, var_27_2)
		elseif var_27_6 == "userdata" then
			if gohelper.isNil(var_27_5) then
				var_27_0 = false
				var_27_1 = string.format("FightTweenWork userdata isNil: %s.%s", arg_27_0.param.type, var_27_2)
			elseif not string.find(tostring(var_27_5), var_27_4) then
				var_27_0 = false
				var_27_1 = string.format("FightTweenWork userdata type not match: %s.%s, expect %s but %s", arg_27_0.param.type, var_27_2, var_27_4, tostring(var_27_5))

				logError(var_27_1)
			end
		elseif var_27_6 ~= var_27_3 then
			var_27_0 = false
			var_27_1 = string.format("FightTweenWork type not match: %s.%s, expect %s but %s", arg_27_0.param.type, var_27_2, var_27_3, var_27_6)
		end
	end

	return var_27_0, var_27_1
end

return var_0_0
