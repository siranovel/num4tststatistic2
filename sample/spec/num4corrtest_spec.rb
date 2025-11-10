require 'spec_helper'
require 'num4corrtest'

RSpec.describe Num4CorrTestLib do
    let!(:a) { 0.05 }
    let!(:rth0) { -0.3 }
    describe Num4CorrTestLib::DecorrTestLib do
        let(:corrTest) { Num4CorrTestLib::DecorrTestLib.new }
        
        it '#pearsoCorrelation' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                corrTest.pearsoCorrelation(x, y, a)
            ).to eq true
        end
        it '#spearmanscorr' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                corrTest.spearmanscorr(x, y, a)
            ).to eq true
        end
        it '#kendallscorr' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                corrTest.kendallscorr(x, y, a)
            ).to eq false
        end
    end
    describe Num4CorrTestLib::CorreFactLib do
        let!(:hypothTest2) { Num4HypothTestLib::TwoSideTestLib.new }
        let(:corrTest) { Num4CorrTestLib::CorreFactLib.new(hypothTest2) }
        it '#pearsoCorrelation' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                corrTest.pearsoCorrelation(x, y, rth0, a)
            ).to eq true
        end
        it '#spearmanscorr' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                corrTest.spearmanscorr(x, y, rth0, a)
            ).to eq true
        end
        it '#kendallscorr' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                corrTest.kendallscorr(x, y, rth0, a)
            ).to eq true
        end
    end
    describe Num4CorrTestLib::DiffCorreFactLib do
        let!(:hypothTest2) { Num4HypothTestLib::TwoSideTestLib.new }
        let(:corrTest) { Num4CorrTestLib::DiffCorreFactLib.new(hypothTest2) }
        it '#pearsoCorrelation' do
            xy1 = [
                    [113, 64, 16, 45, 28, 19, 30, 82, 76],
                    [31, 5, 2, 17, 18, 2, 9, 25, 13]
                  ]
            xy2 = [
                    [113, 64, 16, 45, 28, 19, 30, 82, 76],
                    [31, 5, 2, 17, 18, 2, 9, 25, 13]
                  ]
            expect(
                corrTest.pearsoCorrelation(xy1, xy2, a)
            ).to eq false
        end
        it '#spearmanscorr' do
            xy1 = [
                    [113, 64, 16, 45, 28, 19, 30, 82, 76],
                    [31, 5, 2, 17, 18, 2, 9, 25, 13]
                  ]
            xy2 = [
                    [113, 64, 16, 45, 28, 19, 30, 82, 76],
                    [31, 5, 2, 17, 18, 2, 9, 25, 13]
                  ]
            expect(
                corrTest.spearmanscorr(xy1, xy2, a)
            ).to eq false
        end
        it '#kendallscorr' do
            xy1 = [
                    [113, 64, 16, 45, 28, 19, 30, 82, 76],
                    [31, 5, 2, 17, 18, 2, 9, 25, 13]
                  ]
            xy2 = [
                    [113, 64, 16, 45, 28, 19, 30, 82, 76],
                    [31, 5, 2, 17, 18, 2, 9, 25, 13]
                  ]
            expect(
                corrTest.kendallscorr(xy1, xy2, a)
            ).to eq false
        end
    end
end

