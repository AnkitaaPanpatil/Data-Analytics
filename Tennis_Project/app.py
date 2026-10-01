import streamlit as st
from database import load_table

st.set_page_config(page_title="Tennis Dashboard", layout="wide")

st.sidebar.image(
    "https://upload.wikimedia.org/wikipedia/commons/3/3e/Tennis_Racket_and_Balls.jpg",
    width=200
)

st.title("🎾 Tennis Dashboard")

st.markdown("""
## 📌 Dashboard Summary

This dashboard provides:
- 🏆 Competition Analysis
- 🎾 Competitor Information
- 📊 Ranking Analysis
- 🌍 Country-wise Competitor Analysis
- 🔍 Search Functionality
""")

competitions = load_table("Competitions")
competitors = load_table("Competitors")
rankings = load_table("Competitor_Rankings")

col1, col2, col3 = st.columns(3)

col1.metric("🏆 Competitions", len(competitions))
col2.metric("🎾 Competitors", len(competitors))
col3.metric("📊 Rankings", len(rankings))

st.markdown("---")
st.subheader("🏆 Competitions")

st.dataframe(competitions, use_container_width=True)

st.markdown("---")
st.subheader("🎾 Competitors")

st.dataframe(competitors, use_container_width=True)

st.markdown("---")
st.subheader("📊 Competitor Rankings")

st.dataframe(rankings, use_container_width=True)

st.markdown("---")
st.subheader("🔍 Search Competitor")

search = st.text_input("Enter Competitor Name")

if search:
    filtered = competitors[
        competitors["competitor_name"].str.contains(search, case=False)
    ]
    st.dataframe(filtered, use_container_width=True)

st.markdown("---")
st.subheader("🌍 Filter by Country")

countries = competitors["country"].unique()

selected_country = st.selectbox(
    "Select Country",
    countries
)

filtered_country = competitors[
    competitors["country"] == selected_country
]

st.dataframe(filtered_country, use_container_width=True)

st.markdown("---")
st.subheader("🏆 Top Ranked Players")

top_players = rankings.merge(
    competitors,
    on="competitor_id"
).sort_values("rank_position")

st.dataframe(
    top_players[[
        "rank_position",
        "competitor_name",
        "country",
        "ranking_points"
    ]],
    use_container_width=True
)

import plotly.express as px

st.markdown("---")
st.subheader("📊 Ranking Points")

fig = px.bar(
    top_players,
    x="competitor_name",
    y="ranking_points",
    color="country",
    title="Ranking Points by Competitor"
)

st.plotly_chart(fig, use_container_width=True)

st.markdown("---")
st.subheader("🌍 Competitors by Country")

country_count = competitors.groupby("country").size().reset_index(name="count")

fig2 = px.pie(
    country_count,
    names="country",
    values="count",
    title="Competitors by Country"
)

st.plotly_chart(fig2, use_container_width=True)

st.sidebar.title("🎾 Tennis Dashboard")

table = st.sidebar.selectbox(
    "Choose a Table",
    [
        "Categories",
        "Competitions",
        "Complexes",
        "Venues",
        "Competitors",
        "Competitor_Rankings"
    ]
)

selected_table = load_table(table)

st.sidebar.write(f"Rows: {len(selected_table)}")

st.markdown("---")
st.subheader(f"📋 {table}")

st.dataframe(selected_table, use_container_width=True)

st.markdown("---")
st.header("📂 Database Tables")

tables = [
    "Categories",
    "Competitions",
    "Complexes",
    "Venues",
    "Competitors",
    "Competitor_Rankings"
]

selected = st.selectbox("Select a Table", tables)

df = load_table(selected)

st.dataframe(df, use_container_width=True)

csv = df.to_csv(index=False).encode("utf-8")

st.download_button(
    label="📥 Download CSV",
    data=csv,
    file_name=f"{selected}.csv",
    mime="text/csv"
)