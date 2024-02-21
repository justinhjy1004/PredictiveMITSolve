import polars as pl
from sentence_transformers import SentenceTransformer
import re

"""
This map corresponds to the MITSolve Data column names
and the renamed version for ease of reference (for the most part)

Those that are marked with numbers denote columns that are later 
combined (refer to main for details)

NOT ALL COLUMNS ARE INCLUDED, JUST THOSE THAT I CURRENTLY CARE FOR
"""
rename_map = {
    'Solution ID': "ID",
    'Challenge Name': "Challenge",
    'Solution Status': "Status",
    'What specific problem are you solving?': "Problem",
    'What is your solution?': "Solution",
    'Who does your solution serve, and in what ways will the solution impact their lives?': "Target",
    "How are you and your team well-positioned to deliver this solution?": "TeamPosition",
    "Which dimension of the Challenge does your solution most closely address?": "Dimension",
    r'What is your solution’s stage of development?': "DevStage1",
    "Please share details about what makes your solution a Prototype rather than a Concept.": "DevStage2",
    r"What is your theory of change?": "TheoryOfChange",
    "In what city, town, or region is your solution team headquartered?": "HQ",
    'In what country is your solution team headquartered?': "CountryHQ",
    'How many people does your solution currently serve?': "NumServed",
    'Why are you applying to Solve?': "WhySolve",
    'In which of the following areas do you most need partners or support?': "SupportArea",
    'What makes your solution innovative?': "Innovative",
    'What are your impact goals for the next year and the next five years, and how will you achieve them?': "ImpactGoals",
    'How are you measuring your progress toward your impact goals?': "MeasureImpact",
    'Describe the core technology that powers your solution.': "CoreTech",
    'How do you know that this technology works?': "TechValidation",
    'What is your approach to incorporating diversity, equity, and inclusivity into your work?': "DEI",
    'What is your business model?': "BusinessModel",
    'What is your plan for becoming financially sustainable?': "FinancialSustainability1",
    'Share some examples of how your plan to achieve financial sustainability has been successful so far.': "FinancialSustainability2"
}

# SentenceBERT Model for embeddings
sbert_model = SentenceTransformer('bert-base-nli-mean-tokens')
# Remove HTML tags, encode using SBERT, and then make it a list
encoder = lambda x: sbert_model.encode(re.sub("<.*?>", "", x) if type(x) is str else " ").tolist()

if __name__ == "__main__":

    # Read MIT Solve Data
    df = pl.read_csv("./Data/MITSolve2023.csv")

    # Get relevant columns, and rename them.
    df = df[list(rename_map.keys())]
    df = df.rename(rename_map)
    df = df.fill_nan(" ")

    # Combine Development Stage related questions
    df = df.with_columns(
    pl.concat_str(
        [
            pl.col("DevStage1"),
            pl.col("DevStage2"),
        ],
        separator=" ",
    ).alias("DevStage"))

    # Combine Financial Sustainability related questions
    df = df.with_columns(
        pl.concat_str(
            [
                pl.col("FinancialSustainability1"),
                pl.col("FinancialSustainability2"),
            ],
            separator=" ",
        ).alias("FinancialSustainability"))

    # Combine Tech related questions
    df = df.with_columns(
        pl.concat_str(
            [
                pl.col("CoreTech"),
                pl.col("TechValidation"),
            ],
            separator=" ",
        ).alias("Tech"))

    # Drop combined columns
    df = df.drop(["DevStage1", "DevStage2", "FinancialSustainability1", "FinancialSustainability2", "CoreTech", "TechValidation"])

    # Drop categorical variables and encode the rest
    df = df.drop(["HQ", "CountryHQ", "SupportArea"])
    df = df.with_columns(pl.col(df.columns[3:]).map_elements(encoder))

    # Write Parquet!
    df.write_parquet("./Data/encoded.parquet")