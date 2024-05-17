require 'spec_helper'
require 'corrtest'

RSpec.describe CorrTestLib do
    let!(:a) { 0.05 }
    let!(:rth0) { -0.3 }
    describe CorrTestLib::DecorrTestLib do
        let(:corrTest) { CorrTestLib::DecorrTestLib.new }
        
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
    describe CorrTestLib::CorreFactLib do
        let!(:hypothTest2) { Num4HypothTestLib::TwoSideTestLib.new }
        let(:corrTest) { CorrTestLib::CorreFactLib.new(hypothTest2) }
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
end

